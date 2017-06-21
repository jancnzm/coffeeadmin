class CreatePacts < ActiveRecord::Migration[5.0]
  def change
    create_table :pacts do |t|
      t.integer :busine_id
      t.integer :user_id
      t.string :number
      t.datetime :begindate
      t.datetime :enddate
      t.integer :status

      t.timestamps
    end
  end
end
