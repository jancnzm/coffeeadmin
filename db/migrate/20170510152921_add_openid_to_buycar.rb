class AddOpenidToBuycar < ActiveRecord::Migration[5.0]
  def change
    add_column :buycars, :openid, :string
  end
end
