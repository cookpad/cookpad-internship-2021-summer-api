class OrderItem < ApplicationRecord
    belongs_to :product, optional: false
  end
  