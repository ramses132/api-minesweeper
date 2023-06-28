# frozen_string_literal: true

# Cell Service Business Logic
class CellService
  include Dependencies[:cell_repository]

  def find_by_id(id)
    @pcell_repository.find_by_id(id)
  end

  def find_neighbors_loop(cell, cells)
    offsets = [-1, 0, 1]
    neighbors = []

    offsets.each do |row_offset|
      offsets.each do |col_offset|
        next if row_offset.zero? && col_offset.zero?

        neighbor_row = cell.row + row_offset
        neighbor_col = cell.column + col_offset

        next if neighbor_row.negative? || neighbor_col.negative?
        next if neighbor_row >= cell.game.rows || neighbor_col >= cell.game.columns

        neighbor = cells.find { |c| c.row == neighbor_row && c.column == neighbor_col }
        neighbors << neighbor if neighbor
      end
    end

    neighbors
  end

  def count_neighboring_mines(cell, cells)
    neighbors = find_neighbors_loop(cell, cells)
    return 0 if neighbors.nil?

    neighbors.count(&:mine?)
  end

  def reveal_recursive(cell, cells)
    return if cell.revealed?

    cell.update(state: :revealed)

    return if cell.mine?

    neighboring_mines = count_neighboring_mines(cell, cells)
    if neighboring_mines.positive?
      cell.update(content: neighboring_mines + 1)
    else
      find_neighbors_loop(cell, cells).each do |neighbor|
        reveal_recursive(neighbor, cells)
      end
    end
  end
end
