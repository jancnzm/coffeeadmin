class AddDgtidToWxuser < ActiveRecord::Migration[5.0]
  def change
    add_column :wxusers, :dgt_id, :integer
  end
end
