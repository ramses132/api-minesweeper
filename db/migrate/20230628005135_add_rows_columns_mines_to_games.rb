class AddRowsColumnsMinesToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :rows, :integer
    add_column :games, :columns, :integer
    add_column :games, :mines, :integer
  end
end
