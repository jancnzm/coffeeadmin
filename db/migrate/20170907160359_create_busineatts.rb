class CreateBusineatts < ActiveRecord::Migration[5.0]
  def change
    create_table :busineatts do |t|
      t.integer :busine_id
      t.integer :taobei
      t.integer :tuopan
      t.integer :type

      t.timestamps
    end
  end
end
