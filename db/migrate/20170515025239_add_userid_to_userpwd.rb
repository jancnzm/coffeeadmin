class AddUseridToUserpwd < ActiveRecord::Migration[5.0]
  def change
    add_column :userpwds, :user_id, :integer
  end
end
