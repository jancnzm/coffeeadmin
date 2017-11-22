class AddInvoicetypeToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :invoicetype, :integer
  end
end
