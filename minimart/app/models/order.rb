class Order < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :pickup_location, optional: true
end
