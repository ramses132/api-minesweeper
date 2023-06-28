class RenameValueColumnInCells < ActiveRecord::Migration[7.0]
  def change
    rename_column :cells, :value, :content
  end
end
