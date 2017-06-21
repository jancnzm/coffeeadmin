class AddStatusToBuycar < ActiveRecord::Migration[5.0]
  def change
    add_column :buycars, :status, :integer
  end
end
