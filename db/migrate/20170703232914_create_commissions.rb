class CreateCommissions < ActiveRecord::Migration[5.0]
  def change
    create_table :commissions do |t|
      t.integer :user_id
      t.float :commission

      t.timestamps
    end
  end
end
