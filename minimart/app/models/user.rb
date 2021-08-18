class User < ApplicationRecord
  belongs_to :pickup_location, optional: true
  has_many :orders
end
