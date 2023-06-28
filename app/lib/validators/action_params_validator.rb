# frozen_string_literal: true

# action parameters Validator
class ActionParamsValidator
  def initialize(params)
    @params = params
  end

  def validate
    validate_game_id
    validate_cell_id
    validate_player_id
  end

  private

  def validate_game_id
    game_id = Integer(@params[:id])
    raise InvalidArgumentError, 'Invalid game ID' unless game_id.positive?
  rescue ArgumentError
    raise InvalidArgumentError, 'Invalid game ID'
  end

  def validate_player_id
    player_id = Integer(@params[:player_id])
    raise InvalidArgumentError, 'Invalid player ID' unless player_id.positive?
  rescue ArgumentError
    raise InvalidArgumentError, 'Invalid player ID'
  end

  def validate_cell_id
    cell_id = Integer(@params[:cell_id])
    raise InvalidArgumentError, 'Invalid cell ID' unless cell_id.positive?
  rescue ArgumentError
    raise InvalidArgumentError, 'Invalid cell ID'
  end
end
