# frozen_string_literal: true

# Represent a player in the game
class Player < ApplicationRecord
  # Relations
  has_many :games, dependent: :destroy

  # Attributes
  attribute :name, :string
  attribute :score, :integer

  # Validaciones
  validates :name, presence: true, uniqueness: true
  validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def initialize(name)
    super()
    self.name = name
    self.score = 0
  end

  def find_by_name(name)
    where('LOWER(name) LIKE ?', "%#{name.downcase}%").first
  end

  def increment_score(points)
    self.score += points
    save
  end

  def add_game(game)
    games << game
    save
  end
end
