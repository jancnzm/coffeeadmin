class AddBusineidToBusine < ActiveRecord::Migration[5.0]
  def change
    add_column :busines, :busine_id, :integer
  end
end
