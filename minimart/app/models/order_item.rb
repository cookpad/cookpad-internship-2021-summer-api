class OrderItem < ApplicationRecord
  belongs_to :product, optional: false
  belongs_to :order, optional: false
end
