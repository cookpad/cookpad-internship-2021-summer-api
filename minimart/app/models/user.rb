class User < ApplicationRecord
  belongs_to :pickup_location, optional: true
end
