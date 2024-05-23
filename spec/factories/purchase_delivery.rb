FactoryBot.define do
  factory :purchase_delivery do
    token         {"tok_abcdefghijk00000000000000000"}
    post_code     { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 2..48) }
    municipality  { Gimei.city.kanji }
    address       { "#{Faker::Number.digit}-#{Faker::Number.within(range: 1..50)}" }
    building      { Faker::Address.secondary_address }
    telephone     { "#{Faker::Number.within(range: 1000000000..99999999999)}" }
  end
end