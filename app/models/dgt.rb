class Dgt < ApplicationRecord
  has_many :products
  has_many :dgtfees
  has_many :ecas
end
