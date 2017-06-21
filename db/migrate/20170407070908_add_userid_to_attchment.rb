class AddUseridToAttchment < ActiveRecord::Migration[5.0]
  def change
    add_column :attchments, :userid, :string
  end
end
