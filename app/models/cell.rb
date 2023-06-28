# frozen_string_literal: true

# Model Cell
class Cell < ApplicationRecord
  # relations
  belongs_to :game

  # Attributes
  enum state: { covered: 0, revealed: 1, flagged: 2, questioned: 3 }
  enum content: { empty: 0, mine: 1, one: 2, two: 3, three: 4, four: 5, five: 6, six: 7, seven: 8, eight: 9 }
  attribute :row, :integer
  attribute :column, :integer

  validates :row, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :column, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :state, presence: true
  validates :content, presence: true

  def revealed
    state == :revealed
  end

  def mine
    content == :mine
  end

  def flagged
    state == :flagged
  end

  def questioned
    state == :questioned
  end
end
