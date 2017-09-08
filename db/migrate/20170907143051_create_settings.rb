class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.float :cupratio

      t.timestamps
    end
  end
end
