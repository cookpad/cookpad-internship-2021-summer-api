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

80.times do |i|
  Product.create!(
    name:"オクラ",
    description:"夏バテ防止にネバネバパワーの新鮮オクラをご賞味ください。Mサイズ中心の食べ易い大きさです。グリの野菜は鮮度が生命、オクラのウブ毛を体験して下さい。",
    price:165,
    image_url:"#{i}.jpg",
  )
end


user = User.create!(
  name: 'tomart',
  pickup_location: pickup_location,
)
