# frozen_string_literal: true

# Represent The minesweeper game
class Game < ApplicationRecord
  # relations
  belongs_to :player
  has_many :cells

  # Attributes
  enum state: { win: 'W', lose: 'L', ongoing: 'O' }

  attribute :state, :string, default: 'O'
  attribute :started_at, :datetime
  attribute :ended_at, :datetime
  attribute :columns, :integer
  attribute :rows, :integer
  attribute :mines, :integer

  # Constants
  WIN = 'W'
  LOSE = 'L'
  ONGOING = 'O'
  STATES = [WIN, LOSE, ONGOING].freeze

  # Validations
  validates :state, presence: true
  validates :started_at, presence: true
  validates :ended_at, presence: true, allow_nil: true
  validates :columns, presence: true
  validates :rows, presence: true
  validates :mines, presence: true

  def duration
    return unless started_at && ended_at

    ended_at - started_at
  end

  def on_going
    state == :ongoing
  end

  def finish_game(state)
    # logic to finish game and change game state to (W or L)
    self.state = state
    self.ended_at = Datetime.current
    save
  end

  def board
    max_row = cells.map(&:row).max
    max_column = cells.map(&:column).max

    # Crea la matriz (board) inicializada con celdas vacías
    board = Array.new(max_row + 1) { Array.new(max_column + 1, ' . ') }

    cells.each do |cell|
      board[cell.row][cell.column] = cell
    end
    board
  end
end
