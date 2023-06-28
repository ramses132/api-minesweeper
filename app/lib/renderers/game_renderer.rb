# frozen_string_literal: true

# Game Renderer
class GameRenderer
  def self.render_game_response(game)
    {
      game_id: game.id,
      columns: game.columns,
      rows: game.rows,
      player_id: game.player.id,
      mines: game.mines,
      cells: render_cells(game.cells)
    }
  end

  def self.render_error_response(error)
    { error: error.message }
  end

  def self.render_errors_response(errors)
    { errors: errors.full_messages }
  end

  def self.render_params_error_response
    { error: 'Params Error' }
  end

  def self.render_cells(cells)
    cells.present? ? cells.map { |cell| render_cell(cell) } : []
  end

  def self.render_cell(cell)
    {
      cell_id: cell.id,
      content: cell.content,
      state: cell.state,
      row: cell.row,
      column: cell.column
      # Include other cell attributes as needed
    }
  end
end
