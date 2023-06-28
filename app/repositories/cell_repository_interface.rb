# Aggregate Root Interface for Cell Repository
class CellRepositoryInterface
  def create(attributes)
    raise NotImplementedError, 'Implement this method in a subclass'
  end

  def find_by_id(id)
    raise NotImplementedError, 'Implement this method in a subclass'
  end

  def update_content(cell, content)
    raise NotImplementedError, 'Implement this method in a subclass'
  end
end
