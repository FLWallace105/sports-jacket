FactoryBot.define do
  # pseudo table of line_items_fixed and line_items_variable
  factory :order_line_item do
    shopify_variant_id { Faker::Number.number(14) }
    product_title { "3 Months - 3 Items" }
    subscription_id { Faker::Number.number(8) }
    shopify_product_id { Faker::Number.number(13) }
    variant_title { "" }
    quantity { 1 }
    charge_interval_frequency { 3 }
    charge_interval_unit_type { "Months" }
    leggings { "M" }
    tops { "M" }
    product_collection { "Golden Hour - 3 Items" }
    shipping_interval_frequency { 1 }
    shipping_interval_unit_type { "Months" }
    referrer { "" }
  end
end
