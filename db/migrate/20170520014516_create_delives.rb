class CreateDelives < ActiveRecord::Migration[5.0]
  def change
    create_table :delives do |t|
      t.string :delive

      t.timestamps
    end
  end
end
