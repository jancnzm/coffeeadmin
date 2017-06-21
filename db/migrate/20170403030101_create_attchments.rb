class CreateAttchments < ActiveRecord::Migration[5.0]
  def change
    create_table :attchments do |t|
      t.integer :pact_id
      t.string :attchment

      t.timestamps
    end
  end
end
