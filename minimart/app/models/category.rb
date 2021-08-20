class Category < ApplicationRecord
  has_many :categories_products, dependent: :restrict_with_exception
  has_many :products, through: :categories_products
end
