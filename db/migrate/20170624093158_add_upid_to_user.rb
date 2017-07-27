class AddUpidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :up_id, :integer
  end
end
