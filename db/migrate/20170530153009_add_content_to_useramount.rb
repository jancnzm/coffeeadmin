class AddContentToUseramount < ActiveRecord::Migration[5.0]
  def change
    add_column :useramounts, :content, :string
  end
end
