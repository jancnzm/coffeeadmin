class CreateDgts < ActiveRecord::Migration[5.0]
  def change
    create_table :dgts do |t|
      t.string :name
      t.string :contact
      t.string :phone

      t.timestamps
    end
  end
end
