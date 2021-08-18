class ProductOrder < ApplicationRecord
  belongs_to :order
  belongs_to :product

  has_one :products
end
