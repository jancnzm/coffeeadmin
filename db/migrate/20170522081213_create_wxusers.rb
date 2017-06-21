class CreateWxusers < ActiveRecord::Migration[5.0]
  def change
    create_table :wxusers do |t|
      t.string :openid
      t.string :nickname
      t.integer :sex
      t.string :address
      t.string :headimgurl

      t.timestamps
    end
  end
end
