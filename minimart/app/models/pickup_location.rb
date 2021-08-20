class PickupLocation < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception
  has_many :orders, dependent: :restrict_with_exception
end
