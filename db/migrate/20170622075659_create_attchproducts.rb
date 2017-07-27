class CreateAttchproducts < ActiveRecord::Migration[5.0]
  def change
    create_table :attchproducts do |t|
      t.string :name
      t.integer :number
      t.string :flag
      t.integer :status
      t.integer :pact_id

      t.timestamps
    end
  end
end
