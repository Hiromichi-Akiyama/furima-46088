FactoryBot.define do
  factory :address do
    postal_code   { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number  { Faker::Number.leading_zero_number(digits: 11) }
    association :order
  end
end
