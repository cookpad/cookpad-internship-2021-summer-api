# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pickup_location = PickupLocation.create!(name: 'WeWork みなとみらい')

9.times do |i|
  PickupLocation.create!(name: "受け取り場所 #{i}")
end

user = User.create!(
  name: 'tomart',
  pickup_location: pickup_location,
)

[5, 10, 15].each_with_index do |name, i|
end


9.times do |i|
  newPro = Product.create!(
    name: "#{i}ですよ",
    description: "#{i}番目ですね",
    price: 10*i,
    image_url: ""
  )
  OrderItem.create!(
    products: newPro,
    quantity: 10
  )
end