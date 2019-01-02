SIZES = %w(S M L XL)
PRODUCT_COLLECTION = 'Street Smarts - 3 Items'

FactoryBot.define do
  factory :subscription do
    subscription_id { rand.to_s[2..9] }
    address_id { rand.to_s[2..9] }
    customer_id { rand.to_s[2..9] }
    product_title { "Test Collection" }
    shopify_product_id { rand.to_s[2..14] }
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
        "value": "#{rand.to_s[2..14]}"
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
  end
end
