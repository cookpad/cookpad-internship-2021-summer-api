class Order < ApplicationRecord
  belongs_to :user
  belongs_to :pickup_location
  has_many :order_items

  def self.calc_delivery_date
    tomorrow = Time.current.tomorrow
    Time.new(tomorrow.year, tomorrow.month, tomorrow.day, '12', '0', '0')
  end
end
