class AddAmountToDgt < ActiveRecord::Migration[5.0]
  def change
    add_column :dgts, :amount, :float
    add_column :dgts, :amountsub, :float
  end
end
