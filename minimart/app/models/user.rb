class User < ApplicationRecord
  belongs_to :pickup_location, optional: true
  has_many :orders, dependent: :restrict_with_exception
  has_many :paid_orders, -> { paid.order(:ordered_at) }, class_name: 'Order'

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
end
