class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :login
      t.string :password_digest
      t.string :phonecode
      t.datetime :phonecodetime
      t.float :balance
      t.integer :isnew

      t.timestamps
    end
  end
end
