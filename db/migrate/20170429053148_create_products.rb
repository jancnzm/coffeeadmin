class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :dgt_id
      t.string :name
      t.string :unit
      t.float :price
      t.text :detail
      t.text :spec

      t.timestamps
    end
  end
end
