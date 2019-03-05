PRODUCT_COLLECTION ||= "Mauve Muse - 3 Items"

FactoryBot.define do
  factory :sub_line_item, aliases: [:line_item] do
    name { 'product_collection' }
    value { PRODUCT_COLLECTION }
    subscription
  end
end
