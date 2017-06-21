class CreateGiveawaybusines < ActiveRecord::Migration[5.0]
  def change
    create_table :giveawaybusines do |t|
      t.integer :busine_id

      t.timestamps
    end
  end
end
