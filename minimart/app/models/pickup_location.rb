class PickupLocation < ApplicationRecord
  has_many :users, dependent: :restrict_with_exception
  has_many :order, dependent: :restrict_with_exception
end
