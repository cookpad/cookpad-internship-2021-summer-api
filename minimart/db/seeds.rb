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

Product.create!(name: "にんじん", description: "オレンジ色の野菜", price: 50, image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Mrkva.JPG/1024px-Mrkva.JPG")
Product.create!(name: "大根", description: "白色の野菜", price: 60, image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Daikon.Japan.jpg/200px-Daikon.Japan.jpg")
