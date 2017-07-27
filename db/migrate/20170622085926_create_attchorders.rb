class CreateAttchorders < ActiveRecord::Migration[5.0]
  def change
    create_table :attchorders do |t|
      t.integer :buycar_id
      t.string :name
      t.integer :number
      t.string :flag

      t.timestamps
    end
  end
end
