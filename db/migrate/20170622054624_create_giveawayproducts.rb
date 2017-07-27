class CreateGiveawayproducts < ActiveRecord::Migration[5.0]
  def change
    create_table :giveawayproducts do |t|
      t.integer :giveaway_id
      t.integer :product_id

      t.timestamps
    end
  end
end
