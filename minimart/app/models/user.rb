class User < ApplicationRecord
  belongs_to :pickup_location, optional: true
  has_many :order, dependent: :restrict_with_exception
end
