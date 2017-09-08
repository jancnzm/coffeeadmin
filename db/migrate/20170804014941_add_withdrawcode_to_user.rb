class AddWithdrawcodeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :withdrawcode, :string
    add_column :users, :withdrawcodetime, :datetime
  end
end
