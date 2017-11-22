class CreateEcas < ActiveRecord::Migration[5.0]
  def change
    create_table :ecas do |t|
      t.integer :dgt_id
      t.string :name
      t.string :phone
      t.string :openid

      t.timestamps
    end
  end
end
