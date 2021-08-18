class Order < ApplicationRecord
  belongs_to :order_item
  belongs_to :product
  has_many :order_items
end
