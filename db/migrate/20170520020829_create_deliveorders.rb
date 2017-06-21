class CreateDeliveorders < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveorders do |t|
      t.string :delive
      t.integer :buycar_id
      t.integer :dgt_id

      t.timestamps
    end
  end
end
