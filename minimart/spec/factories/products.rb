FactoryBot.define do
  factory :product do
    name { '玉ねぎ' }
    description { "とてもおいしい#{name}" }
    price { 100 }
    image_path { '/images/products/1.jpg' }
  end
end
