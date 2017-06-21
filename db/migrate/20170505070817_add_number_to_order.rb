class AddNumberToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :number, :integer
  end
end
