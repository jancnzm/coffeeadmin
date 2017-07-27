class Giveaway < ApplicationRecord
  has_many :giveawaybusines, dependent: :destroy
  has_many :giveawayproducts, dependent: :destroy
end
