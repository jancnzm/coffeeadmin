class AddOrdernumberToDeliveorder < ActiveRecord::Migration[5.0]
  def change
    add_column :deliveorders, :ordernumber, :string
  end
end
