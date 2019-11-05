require_relative '../../config/environment'

recharge_token = ENV['RECHARGE_ACCESS_TOKEN']
recharge_change_header = {
  'X-Recharge-Access-Token' => recharge_token,
  'Accept' => 'application/json',
  'Content-Type' => 'application/json'
}

def determine_limits(recharge_header, limit)
  puts "recharge_header = #{recharge_header}"
  my_numbers = recharge_header.split("/")
  my_numerator = my_numbers[0].to_f
  my_denominator = my_numbers[1].to_f
  my_limits = (my_numerator/ my_denominator)
  puts "We are using #{my_limits} % of our API calls"
  if my_limits > limit
      puts "Sleeping 10 seconds"
      sleep 10
  else
      puts "not sleeping at all"
  end
end

no_price_orders = Order.find_by_sql(
  "SELECT * FROM orders ord, jsonb_array_elements(ord.line_items) obj
  where obj->>'price' is null and status = 'QUEUED' and is_prepaid = 1;"
)
puts "WE HAVE #{no_price_orders.size} TO PROCESS"

no_price_orders.each do |order|
  new_line_items = []
  order.line_items.each do |line_item|
    if line_item.key?('price')
      price = line_item['price']
    else
      price = "0.00"
    end

    temp_item = {
      "properties" => line_item['properties'],
      "quantity" => line_item['quantity'].to_i,
      "price" => price,
      "sku" => line_item['sku'],
      "title" => line_item['title'],
      "variant_title" => line_item['variant_title'],
      "product_id" => line_item['shopify_product_id'].to_i,
      "variant_id" => line_item['shopify_variant_id'].to_i,
      "subscription_id" => line_item['subscription_id'].to_i,
    }
    new_line_items.push(temp_item)
  end
  my_hash = { "line_items" => new_line_items }
  order_body = my_hash.to_json
  puts "order id: #{order.order_id}"
  puts order_body
  my_update_order = HTTParty.put("https://api.rechargeapps.com/orders/#{order.order_id}", :headers => recharge_change_header, :body => order_body, :timeout => 80)
  puts "RECHARGE ORDER RESPONSE: #{my_update_order.parsed_response}"
  determine_limits(my_update_order.response["x-recharge-limit"], 0.80)
end
