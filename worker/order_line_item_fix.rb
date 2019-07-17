require 'dotenv'
Dotenv.load
require_relative '../lib/logging'

module OrderLineItemFix
  # select all orders that are prepaid and have incorrect line_item data
  def self.run
    product_map = { "3 Months - 5 Items": {},
                    "3 MONTHS": {},
                    "3 Months - 3 Items": {},
                  }
    sql_query = "SELECT * from orders ord INNER JOIN order_line_items_fixed ordfix ON
          ordfix.order_id = ord.order_id WHERE ord.scheduled_at > '2019-07-16' AND ord.is_prepaid = 1
          AND ordfix.product_title NOT LIKE '%Months%' AND ordfix.title NOT LIKE '%Months%'
          AND ordfix.product_title NOT LIKE '%MONTHS%' AND ordfix.title NOT LIKE '%MONTH%' AND ord.status='QUEUED'
          AND ord.customer_id NOT IN ('25181922','26016178');"
          # customer ids '25181922','26016178' belong to devi_team and Lourdes
    bad_orders = Order.find_by_sql(sql_query)
    puts "bad orders count: #{bad_orders.size}"
    count = 1
    bad_orders.each do |order|
      subscription_id = order.line_items[0]['subscription_id']
      puts "#{count})"
      puts "working on subscription: #{subscription_id}"
      puts "bad_order_id: #{order.order_id}"
      count = count + 1
      og_product_title = find_original(order.customer_id, subscription_id)
      update_order(order.order_id, og_product_title)
    end
  end

  def self.find_original(customer_id, sub_id)
    recharge_regular = ENV['RECHARGE_ACCESS_TOKEN']
    my_header = {
      "X-Recharge-Access-Token" => recharge_regular
    }
    cust_id = customer_id
    subscription_id = sub_id
    orders = HTTParty.get("https://api.rechargeapps.com/orders?customer_id=#{cust_id}&status=SUCCESS", :headers => my_header)
    my_orders = orders.parsed_response['orders']
    original_product_title = ""
    if my_orders.size < 1
      puts "no SUCCESS status, orders found for customer: #{cust_id}"
      return
    else
      done = false
      my_orders.each do |order|
        next unless (order['tags'].include?('Prepaid') && order['tags'].include?('First'))
        order['line_items'].each do |l_item|
          begin
            # find matching line_item (in the event there are multiple products in first order)
            if l_item['subscription_id'].to_s == subscription_id.to_s
                puts "found first prepaid order: #{order['id']}"
               if l_item.key?('title')
                 puts "original product: #{l_item['title']}"
                 puts "product_id: #{l_item['shopify_product_id']}"
                 done = true
                 original_product_title = l_item['title']
               elsif l_item.key?('product_title')
                 puts "original product: #{l_item['product_title']}"
                 puts "product_id: #{l_item['shopify_product_id']}"
                 original_product_title = l_item['product_title']
                 done = true
               end
            else
              puts "line_items missing sub id: #{subscription_id}"
              puts "orginal item guess: #{order['line_items'][-1]['title']}"
              puts "product_id: #{order['line_items'][-1]['title']}"
              original_product_title = order['line_items'][-1]['title']
              done = true
            end
          rescue NoMethodError
            puts"RESCUED: #{order['id']}"
          end #rescue end
        end
        # exit order loop once original found
        # some orders have duplicate originals, loop chooses the first it encounters
        break if done
      end
      puts "---------------------------------"
      return original_product_title
    end
  end

  def self.update_order(order_id_str, og_prod_title)
    recharge_token = ENV['RECHARGE_ACCESS_TOKEN']
    # recharge_token = 'b898074b3a4e4f16b6325aaad26353c3'
    recharge_change_header = {
      'X-Recharge-Access-Token' => recharge_token,
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    order_id = order_id_str
    og_prod = Product.find_by_title(og_prod_title)
    og_variant = EllieVariant.find_by_product_id(og_prod.shopify_id)

    my_order = Order.find(order_id)
    old_line_item = my_order.line_items[0]
    puts "BEFORE: #{old_line_item.inspect}"
    new_line_item = {
      "properties" => old_line_item['properties'],
      "quantity" => old_line_item['quantity'].to_i,
      "sku" => og_variant.sku.to_s,
      "price" => "0.00",
      "product_title" => og_prod.title,
      "title" => og_prod.title,
      "variant_title" => og_variant.title,
      "product_id" => og_prod.shopify_id.to_i,
      "variant_id" => og_variant.variant_id,
      "subscription_id" => old_line_item['subscription_id'].to_i,
    }
    puts"----------------------------------------"
    puts "PREREQUEST: #{new_line_item.inspect}"

    my_hash = { "line_items" => [new_line_item] }
    body = my_hash.to_json
    my_update_order = HTTParty.put("https://api.rechargeapps.com/orders/#{order_id}", :headers => recharge_change_header, :body => body, :timeout => 80)

    puts "MY RECHARGE RESPONSE: #{my_update_order.parsed_response}"
    if my_update_order.code == 200
      logger.info "--------SUCCESS--------"
    else
      puts "--------Failure--------(see recharge response above)"
    end
  end

end
