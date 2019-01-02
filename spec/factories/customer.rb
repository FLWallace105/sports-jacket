FactoryBot.define do
  factory :customer do
    customer_id { rand.to_s[2..9] }
    shopify_customer_id { rand.to_s[2..13] }
    first_name { Faker::Name.first_name }
    last_nam
  end
end
