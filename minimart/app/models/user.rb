class User < ApplicationRecord
  belongs_to :pickup_location, optional: true
  has_many :paid_orders, -> { paid.order(:ordered_at) }, class_name: 'Order'
end
