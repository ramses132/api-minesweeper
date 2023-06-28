class AddGameIdToCells < ActiveRecord::Migration[7.0]
  def change
    add_column :cells, :game_id, :integer
  end
end
