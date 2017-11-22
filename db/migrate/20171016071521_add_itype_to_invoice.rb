class AddItypeToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :itype, :integer
  end
end
