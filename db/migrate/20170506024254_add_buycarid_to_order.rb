class AddBuycaridToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :buycar_id, :integer
  end
end
