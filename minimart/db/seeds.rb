# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pickup_location = PickupLocation.create!(name: 'WeWork みなとみらい',description: '')

9.times do |i|
  PickupLocation.create!(name: "受け取り場所 #{i}",description: '')
end



user = User.create!(
  name: 'reiji-kobayashi'
)

12.times do |i|
  Product.create!(
    name: "#{i}個目の野菜",
    description: "#{i}個目の説明",
    price: 1000*i,
    imageUrl: "https://1.bp.blogspot.com/-C88IOuzG34k/XTPoqMzYmxI/AAAAAAABT04/YPROD6yXK-oiS5VN3n52GU6SEUlC3CcVACLcBGAs/s800/sweets_marzipan_cake.png"
  )
end
