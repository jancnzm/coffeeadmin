class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :name
      t.string :tax
      t.string :address
      t.string :tel
      t.string :bankdeposit
      t.string :bankaccount
      t.integer :busine_id

      t.timestamps
    end
  end
end
