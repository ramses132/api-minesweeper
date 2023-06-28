# frozen_string_literal: true

# Game parameters Validator
class GameParamsValidator
  def initialize(params)
    @params = params
  end

  def validate
    validate_player_id
    validate_rows
    validate_columns
    validate_mines
  end

  private

  def validate_rows
    rows = Integer(@params[:rows])
    raise InvalidArgumentError, 'Invalid number of rows' unless rows >= 1
  end

  def validate_columns
    columns = Integer(@params[:columns])
    raise InvalidArgumentError, 'Invalid number of columns' unless columns >= 1
  end

  def validate_mines
    mines = Integer(@params[:mines])
    rows = Integer(@params[:rows])
    columns = Integer(@params[:columns])
    raise InvalidArgumentError, 'Invalid number of mines' unless mines >= 1 && mines < rows * columns
  end

  def validate_player_id
    player_id = Integer(@params[:player_id])
    raise InvalidArgumentError, 'Invalid player ID' unless player_id.positive?
  rescue ArgumentError
    raise InvalidArgumentError, 'Invalid player ID'
  end
end
