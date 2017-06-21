class Buycar < ApplicationRecord
  belongs_to :busine
  has_many :orders
  has_many :deliveorders
end
