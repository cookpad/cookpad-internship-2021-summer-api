class Order < ApplicationRecord
    belongs_to :user, optional: false
    belongs_to :pickup_location, optional: false
    has_many :order_items, dependent: :delete_all
  end
  