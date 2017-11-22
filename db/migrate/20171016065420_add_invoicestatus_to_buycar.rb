class AddInvoicestatusToBuycar < ActiveRecord::Migration[5.0]
  def change
    add_column :buycars, :invoicestatus, :integer
  end
end
