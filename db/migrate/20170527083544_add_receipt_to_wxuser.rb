class AddReceiptToWxuser < ActiveRecord::Migration[5.0]
  def change
    add_column :wxusers, :receipt, :integer
  end
end
