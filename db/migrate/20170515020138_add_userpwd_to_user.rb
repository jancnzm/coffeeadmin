class AddUserpwdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :userpwd_digest, :string
  end
end
