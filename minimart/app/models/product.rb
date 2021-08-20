class Product < ApplicationRecord
  has_many :order_items, dependent: :restrict_with_exception

  scope :search, ->(term) { where("name like ? or description like ?", "%#{term}%", "%#{term}%") }
end
