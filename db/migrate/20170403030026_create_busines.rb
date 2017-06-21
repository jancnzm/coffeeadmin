class CreateBusines < ActiveRecord::Migration[5.0]
  def change
    create_table :busines do |t|
      t.string :name
      t.string :address
      t.string :province
      t.string :city
      t.string :districe
      t.string :contact
      t.string :contactphone
      t.string :buessphone

      t.timestamps
    end
  end
end
