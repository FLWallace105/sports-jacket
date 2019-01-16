SIZES = %w(S M L XL)
PRODUCT_COLLECTION = "Fierce & Floral - 3 Items"
PREPAIDTHREE = 1635509436467
PREPAIDFIVE = 1635509469235
FactoryBot.define do
  factory :subscription do
    subscription_id { rand.to_s[2..9] }
    product_title { PRODUCT_COLLECTION }
    shopify_product_id { PREPAIDTHREE }
    shopify_variant_id { rand.to_s[2..14] }
    sku { rand.to_s[2..15] }
    order_interval_unit { "month" }
    order_interval_frequency { 1 }
    charge_interval_frequency { 3 }
    raw_line_item_properties {
      [{
        "name": "charge_interval_frequency",
        "value": "3"
    },{
        "name": "charge_interval_unit_type",
        "value": "Months"
    },{
        "name": "leggings",
        "value": "#{SIZES.sample}"
    },{
        "name": "main-product",
        "value": "true"
    },{
        "name": "product_collection",
        "value": PRODUCT_COLLECTION
    },{
        "name": "product_id",
        "value": PREPAIDTHREE,
    },{
        "name": "referrer",
        "value": ""
    },{
        "name": "shipping_interval_frequency",
        "value": "1"
    },{
        "name": "shipping_interval_unit_type",
        "value": "Months"
    },{
        "name": "sports-bra",
        "value": "#{SIZES.sample}"
    },{
        "name": "tops",
        "value": "#{SIZES.sample}"
    }] }
    expire_after_specific_number_charges { 0 }
    customer
    factory :subscription_with_line_items do
      transient do
        line_items_count { 2 }
      end
      after(:create) do |subscription, evaluator|
        create_list(:line_item, evaluator.line_items_count, subscription: subscription)
      end

    end
  end
end
