class CreateGiveaways < ActiveRecord::Migration[5.0]
  def change
    create_table :giveaways do |t|
      t.string :name
      t.integer :enable
      t.datetime :begindate
      t.datetime :enddate
      t.integer :buyproduct_id
      t.integer :giveproduct_id
      t.integer :buynum
      t.integer :givenum
      t.integer :once

      t.timestamps
    end
  end
end
