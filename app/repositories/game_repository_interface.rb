# Aggregate Root Interface for player Repository
class GameRepositoryInterface
  def create(attributes)
    raise NotImplementedError, 'Implement this method in a subclass'
  end

  def reload(game)
    raise NotImplementedError, 'Implement this method in a subclass'
  end
end
