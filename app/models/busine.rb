class Busine < ApplicationRecord
  has_many :pacts
  has_many :buycars
  has_many :invoices
  #has_many :busineatts
end
