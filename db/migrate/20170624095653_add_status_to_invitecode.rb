class AddStatusToInvitecode < ActiveRecord::Migration[5.0]
  def change
    add_column :invitecodes, :status, :integer
  end
end
