# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pickup_location = PickupLocation.create!(name: 'WeWork みなとみらい')

user = User.create!(
  name: 'tomart',
  pickup_location: pickup_location,
)


9.times do |i|
  PickupLocation.create!(name: "受け取り場所 #{i}")

  Product.create!(name: "Good Product #{i}", description: "Nice Description #{i}", price: i * 100, image_url: "goodimage/#{i}")
  Order.create!(user_id: 1, pickup_location_id: 1, total_amount: i * 5, ordered_at: "2021-08-18", delivery_date: "2021-08-19")
  OrderItem.create(product_id: i, quantity: i * 3, order_id: i)
end
