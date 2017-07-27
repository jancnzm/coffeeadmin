class CreateInvitecodes < ActiveRecord::Migration[5.0]
  def change
    create_table :invitecodes do |t|
      t.string :code
      t.integer :user_id

      t.timestamps
    end
  end
end
