class OrderItem < ApplicationRecord
  has_many :products, optional: true
  belongs_to :user, optional: true
end
