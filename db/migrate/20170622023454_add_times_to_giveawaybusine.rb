class AddTimesToGiveawaybusine < ActiveRecord::Migration[5.0]
  def change
    add_column :giveawaybusines, :times, :integer
  end
end
