class CreateDgtfees < ActiveRecord::Migration[5.0]
  def change
    create_table :dgtfees do |t|
      t.integer :dgt_id
      t.float :amount

      t.timestamps
    end
  end
end
