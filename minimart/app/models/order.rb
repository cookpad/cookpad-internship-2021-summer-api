class Order < ApplicationRecord
    belongs_to :user, optional: true
end
