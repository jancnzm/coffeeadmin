class AddStatusToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :status, :integer
  end
end
