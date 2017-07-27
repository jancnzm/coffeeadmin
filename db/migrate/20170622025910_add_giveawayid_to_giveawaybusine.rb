class AddGiveawayidToGiveawaybusine < ActiveRecord::Migration[5.0]
  def change
    add_column :giveawaybusines, :giveaway_id, :integer
  end
end
