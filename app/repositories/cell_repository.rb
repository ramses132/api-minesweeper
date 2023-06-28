# Cell Repository
class CellRepository < CellRepositoryInterface
  def create(attributes)
    Cell.create(attributes)
  end

  def update(cell_id, attributes)
    cell = Cell.find_by(id: cell_id)
    return if cell.nil?

    cell.update(attributes)
  end

  def cell_update_content(cell, content)
    cell.update(content)
  end

  def find_by_id(id)
    Cell.find(id)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
