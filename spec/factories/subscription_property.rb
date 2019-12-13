SIZES ||= ["XS","S","M","L","XL"]
my_size ||= SIZES.sample
FactoryBot.define do
  # pseudo table of line_items_fixed and line_items_variable
  factory :subscription_property do
    subscription_id { Faker::Number.number(8) }
    product_collection { "Comfort Zone - 5 Items" }
    leggings { SIZES.sample }
    tops { SIZES.sample }
    gloves { SIZES.sample }
    unique_identifier { "d6430e07-634f-47a2-8c80-77dd5eccc5d3" }
    product_id { Faker::Number.number(13) }
    shipping_interval_frequency { "1" }
    shipping_interval_unit_type { "Month" }
  end
end
