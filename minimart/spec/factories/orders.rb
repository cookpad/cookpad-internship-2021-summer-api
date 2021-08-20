FactoryBot.define do
  factory :order do
    user
    pickup_location
    minifinancier_payment_id { SecureRandom.uuid }
    ordered_at { Time.zone.now }
    delivery_date { 1.day.since(ordered_at).beginning_of_day + 12.hours }

    factory :order_with_item do
      order_items { [association(:order_item, strategy: :build)] }
    end
  end
end
