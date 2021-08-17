class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pickup_location
  has_many :order_items, dependent: :delete_all
end
