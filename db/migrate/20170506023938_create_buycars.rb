class CreateBuycars < ActiveRecord::Migration[5.0]
  def change
    create_table :buycars do |t|
      t.string :ordernumber
      t.string :name
      t.string :phone
      t.string :address
      t.string :remark
      t.float :amount

      t.timestamps
    end
  end
end
