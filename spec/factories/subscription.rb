require 'faker'

SIZES = %w(XS S M L XL)
PRODUCT_COLLECTION ||= "Mauve Muse - 3 Items"
PREPAID_3_ACTIVE ||= 1635509436467
PREPAID_5_ACTIVE ||= 1635509469235
FactoryBot.define do
  factory :subscription do
    subscription_id { Faker::Number.number(8) }
    product_title { PRODUCT_COLLECTION }
    shopify_product_id { PREPAID_3_ACTIVE.to_s }
    shopify_variant_id { rand.to_s[2..14] }
    sku { rand.to_s[2..15] }
    order_interval_unit { "month" }
    status { 'ACTIVE' }
    order_interval_frequency { 1 }
    charge_interval_frequency { 3 }
    raw_line_item_properties {
      [{
        name: "charge_interval_frequency",
        value: "3"
    },{
        name: "charge_interval_unit_type",
        value: "Months"
    },{
        name: "leggings",
        value: "S"
    },{
        name: "main-product",
        value: "true"
    },{
        name: "product_collection",
        value: PRODUCT_COLLECTION
    },{
        name: "product_id",
        value: PREPAID_THREE,
    },{
        name: "referrer",
        value: ""
    },{
        name: "shipping_interval_frequency",
        value: "1"
    },{
        name: "shipping_interval_unit_type",
        value: "Months"
    },{
        name: "sports-bra",
        value: "S"
    },{
        name: "tops",
        value: "S"
    }] }
    expire_after_specific_number_charges { 0 }
    customer_id { "12248147" } #linked to nlee on elliestaging
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
