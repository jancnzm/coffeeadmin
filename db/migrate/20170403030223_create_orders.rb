class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :busine_id
      t.string :ordernumber
      t.float :paymentamount
      t.integer :status
      t.string :remark
      t.string :linkparams

      t.timestamps
    end
  end
end
