class CreateIdcards < ActiveRecord::Migration[5.0]
  def change
    create_table :idcards do |t|
      t.integer :User_id
      t.string :uuid

      t.timestamps
    end
  end
end
