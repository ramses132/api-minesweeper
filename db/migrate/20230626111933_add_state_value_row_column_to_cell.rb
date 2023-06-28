class AddStateValueRowColumnToCell < ActiveRecord::Migration[7.0]
  def change
    add_column :cells, :state, :integer
    add_column :cells, :value, :integer
    add_column :cells, :row, :integer
    add_column :cells, :column, :integer
  end
end
