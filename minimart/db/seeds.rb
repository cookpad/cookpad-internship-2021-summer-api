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

80.times do |i|
  num = i+1
  Product.create!(
    name: "商品#{num}",
    description: "説明#{num}",
    price: 100+num,
    image_url: "#{num}.png"
  )
end
