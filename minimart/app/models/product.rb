class Product < ApplicationRecord
  has_many :products, dependent: :restrict_with_exception
end
