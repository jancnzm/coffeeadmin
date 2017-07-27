class AddBusineidToAttchproduct < ActiveRecord::Migration[5.0]
  def change
    add_column :attchproducts, :busine_id, :integer
  end
end
