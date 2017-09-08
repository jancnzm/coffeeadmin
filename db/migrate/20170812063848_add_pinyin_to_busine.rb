class AddPinyinToBusine < ActiveRecord::Migration[5.0]
  def change
    add_column :busines, :pinyin, :string
  end
end
