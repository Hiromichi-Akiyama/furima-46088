FactoryBot.define do
  factory :order_address do
    postal_code   { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) } # 1(---)以外のIDを生成
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number  { Faker::Number.leading_zero_number(digits: 11) }
    token         { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
  end
end
