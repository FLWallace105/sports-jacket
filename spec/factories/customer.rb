FactoryBot.define do
  factory :customer do
    customer_id { Faker::Number.number(8) }
    shopify_customer_id { Faker::Number.number(12)}
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    status { 'ACTIVE' }
  end
end
