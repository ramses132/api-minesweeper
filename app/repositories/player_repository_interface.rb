# Aggregate Root Interface for player Repository
class PlayerRepositoryInterface
  def find_by_name(name)
    raise NotImplementedError, 'Implement this method in a subclass'
  end

  def find_by_id(id)
    raise NotImplementedError, 'Implement this method in a subclass'
  end

  def create(attributes)
    raise NotImplementedError, 'Implement this method in a subclass'
  end
end
