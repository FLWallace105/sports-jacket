require_relative '../src/ellie_listener.rb'

Config['shopify'] = {
  shop_name: 'elliestaging',
  api_key: 'aa89e2e4aca8715770a8c5d3149abb98',
  api_shared_secret: 'e6057ee983e9b4c9fafc2363f9864ac9',
  api_password: '0bda7a26942001b0a5728c2e810d4b9f'
}
Config['alt_monthly_product'] = {
  title: 'Go Time',
  sku: '722457737550',
  variant_id: '46479057042',
  product_id: '10870327954'
}
# these values came from elliestaging on 11/28
Config['rollover'] = {
  new_theme_id: 316735506,
  current_collection_id: 19622428704,
  new_current_collection_product_ids: [69026938898, 69026316306],
  past_collection_id: 19623280672,
  new_past_collection_product_ids: [9003059781]
}
