class AddStatusToDgtfee < ActiveRecord::Migration[5.0]
  def change
    add_column :dgtfees, :status, :integer
  end
end
