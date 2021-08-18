class PickupLocation < ApplicationRecord
  #dependent-pickuplocationをデストロイする時に依存関係のある外部キーなどが合った場合の挙動
  has_many :users, dependent: :restrict_with_exception
end
