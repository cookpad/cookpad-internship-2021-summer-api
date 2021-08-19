# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pickup_location = PickupLocation.create!(name: 'WeWork みなとみらい')
pickup_location_2 = PickupLocation.create!(name: 'パークシティ豊洲')
pickup_location_3 = PickupLocation.create!(name: 'ロケーション3')

9.times do |i|
  PickupLocation.create!(name: "受け取り場所 #{i}")
end

4.times do |i|
  Product.create!(name: "深澤さんに奢ってもらう寿司 #{i}, ")
end

user = User.create!([
  {
    name: 'tomart',
    pickup_location: pickup_location,
  },
  {
    name: 'tommy',
    pickup_location: pickup_location_2,
  },
  {
    name: 'hata',
    pickup_location: pickup_location_3,
  }
])