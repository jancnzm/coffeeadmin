class CreateProfits < ActiveRecord::Migration[5.0]
  def change
    create_table :profits do |t|
      t.string :dgt
      t.string :product
      t.integer :number
      t.float :profit

      t.timestamps
    end
  end
end
