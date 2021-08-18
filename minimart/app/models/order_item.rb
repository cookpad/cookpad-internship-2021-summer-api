class OrderItem < ApplicationRecord
  #dependent-pickuplocationをデストロイする時に依存関係のある外部キーなどが合った場合の挙動
  #has_many :orders, dependent: :restrict_with_exception
  belongs_to :product, optional: true
end
