class OrderItem < ApplicationRecord
    belongs_to :order, optional: true
end
