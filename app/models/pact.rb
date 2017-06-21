class Pact < ApplicationRecord
  belongs_to :user
  has_many :attchments
  belongs_to :busine
end
