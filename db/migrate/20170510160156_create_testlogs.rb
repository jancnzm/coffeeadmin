class CreateTestlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :testlogs do |t|
      t.text :log

      t.timestamps
    end
  end
end
