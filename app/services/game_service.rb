# frozen_string_literal: true

# Game Service Business Logic
class GameService
  include Dependencies[:game_repository, :cell_repository, :player_repository, :cell_service]

  def create(rows, columns, player_id, mines)
    find_player(player_id)
    game = nil
    ActiveRecord::Base.transaction do
      game = game_repository.create(player_id:, rows:, columns:, mines:,
                                    started_at: Time.now)
      cells = create_cells(game, rows, columns)
      place_mines(cells, mines)
    end
    game
  end

  def all
    game_repository.all
  end

  def find_by_id(id)
    game = game_repository.find_by_id(id)
    raise ArgumentError, 'Invalid game ID' if game.nil?

    game
  end

  private

  def create_cells(game, rows, columns)
    cells = []

    rows.times.each do |i|
      columns.times.each do |j|
        cells << cell_repository.create(state: :covered, content: :empty, row: i, column: j, game_id: game.id)
      end
    end

    cells
  end

  def place_mines(cells, mines)
    shuffled_cells = cells.shuffle
    mines_cells = shuffled_cells.take(mines)

    mines_cells.each do |cell|
      mark_mine(cell)
    end
  end

  def mark_mine(cell)
    cell_repository.update(cell.id, content: :mine)
  end

  def find_player(player_id)
    player = player_repository.find_by_id(player_id)
    raise ArgumentError, 'Invalid player ID' if player.nil?

    player
  end

  def validate_player_action(game, player)
    raise ArgumentError, 'Invalid game or player ID' unless game && player
    raise ArgumentError, 'Unauthorized Action' unless game.player_id == player.id
  end

  def find_cell(cell_id, game)
    cell = cell_repository.find_by_id(cell_id)
    raise ArgumentError, 'Invalid cell ID' unless cell && cell.game_id == game.id

    cell
  end

  def update_cell_state(cell, new_state)
    cell_repository.update(cell.id, state: new_state)
  end

  def flag_cell(id, cell_id, player_id)
    game = find_by_id(id)
    player = find_player(player_id)
    validate_player_action(game, player)
    cell = find_cell(cell_id, game)
    validate_cell_action(cell, %i[covered questioned flagged])

    new_state = cell.flagged? ? :covered : :flagged
    update_cell_state(cell, new_state)

    game_repository.reload(game)
  end

  def question_cell(id, cell_id, player_id)
    game = find_by_id(id)
    player = find_player(player_id)
    validate_player_action(game, player)
    cell = find_cell(cell_id, game)
    validate_cell_action(cell, %i[covered questioned flagged])

    new_state = cell.questioned? ? :covered : :questioned
    update_cell_state(cell, new_state)

    game_repository.reload(game)
  end

  def reveal_cell(id, cell_id, player_id)
    game = find_by_id(id)
    player = find_player(player_id)

    validate_player_action(game, player)

    cell = find_cell(cell_id, game)

    validate_cell_action(cell, %i[covered questioned flagged])
    cells = game.cells
    cell_service.reveal_recursive(cell, cells)

    game_repository.reload(game)
    update_game_state(game)
    game
  end

  def update_game_state(game)
    if game.cells.exists?(state: :revealed, content: :mine)
      game.update(state: :lose)
    elsif game.cells.where(state: :revealed).count == (game.rows * game.columns) - game.mines
      game.update(state: :win)
    end
  end

  def validate_cell_action(cell, valid_states)
    raise ArgumentError, 'Invalid Action' unless valid_states.include?(cell.state.to_sym)
  end
end
