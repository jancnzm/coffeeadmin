class CreateUseramounts < ActiveRecord::Migration[5.0]
  def change
    create_table :useramounts do |t|
      t.integer :user_id
      t.float :amount

      t.timestamps
    end
  end
end
