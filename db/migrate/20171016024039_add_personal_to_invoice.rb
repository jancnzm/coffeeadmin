class AddPersonalToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :personal, :string
  end
end
