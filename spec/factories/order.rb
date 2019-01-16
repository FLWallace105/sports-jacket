require 'faker'
PRODUCT_COLLECTION = "Fierce & Floral - 3 Items"
PREPAIDTHREE = 1635509436467
PREPAIDFIVE = 1635509469235
month_start = Time.now.beginning_of_month
month_end = Time.now.end_of_month

FactoryBot.define do
  factory :order  do
    transient do
      sub_id { rand.to_s[2..9].to_i }
    end
    order_id { rand.to_s[2..9] }
    status { "SUCCESS" }
    order_type { 'CHECKOUT' }
    # charge_id { rand.to_s[2..9] }
    shopify_id { rand.to_s[2..13] }
    shopify_order_number { rand.to_s[2..5] }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    is_prepaid { 0 }
    scheduled_at { month_end - 2.days }
    shipping_date { month_end - 2.days }
    line_items { [{
    "sku": "99999999",
    "price": "0.00",
    "title": "3 Months 3 items",
    "quantity": 1,
    "properties": [
        {
            "name": "charge_interval_frequency",
            "value": "3"
        },
        {
            "name": "charge_interval_unit_type",
            "value": "Months"
        },
        {
            "name": "leggings",
            "value": "S"
        },
        {
            "name": "main-product",
            "value": "true"
        },
        {
            "name": "product_collection",
            "value": PRODUCT_COLLECTION,
        },
        {
            "name": "product_id",
            "value": PREPAIDTHREE,
        },
        {
            "name": "referrer",
            "value": ""
        },
        {
            "name": "shipping_interval_frequency",
            "value": "1"
        },
        {
            "name": "shipping_interval_unit_type",
            "value": "Months"
        },
        {
            "name": "sports-bra",
            "value": "S"
        },
        {
            "name": "tops",
            "value": "S"
        }
    ],
    "product_title": "3 Months 3 items",
    "variant_title": "",
    "subscription_id": "#{sub_id}",
    "shopify_product_id": PREPAIDTHREE,
    "shopify_variant_id": rand.to_s[2..14],
  }] }
  end
end
