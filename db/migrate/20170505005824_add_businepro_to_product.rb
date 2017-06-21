class AddBusineproToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :businepro, :float
    add_column :products, :dgtpro, :float
  end
end
