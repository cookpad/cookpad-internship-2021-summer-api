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
  Product.create!(
    name: "product #{i}",
    description: "description #{i}",
    price: 100*i,
    imageUrl: "hoge"
  )
end

user = User.create!(
  name: 'Naoki08',
  pickup_location: pickup_location,
)
