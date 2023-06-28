# frozen_string_literal: true

# Game Repository
class GameRepository < GameRepositoryInterface
  def create(attributes)
    Game.create(attributes)
  end

  def find_by_id(id)
    Game.find(id)
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def all
    Game.all
  end

  def reload(game)
    game.reload
  end
end
