class AddInvalidtimeToInvitecode < ActiveRecord::Migration[5.0]
  def change
    add_column :invitecodes, :invalidtime, :datetime
  end
end
