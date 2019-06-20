require_relative 'resque_helper'

class SubscriptionSwitchPrepaid
  extend ResqueHelper
  @queue = "switch_product"

  def self.perform(params)
    puts params.inspect
    Resque.logger = Logger.new("#{Dir.getwd}/logs/prepaid_switch_resque.log")
    updated_line_items = []

    subscription_id = params['subscription_id']
    product_id = params['product_id']
    new_product = AlternateProduct.find_by_product_id(params['real_alt_product_id'])

    puts "We are working on subscription #{subscription_id}"
    Resque.logger.info "my new product id : #{new_product.product_id}"
    Resque.logger.info("We are working on subscription #{subscription_id}")

    response_hash = provide_current_orders(product_id, subscription_id, new_product.product_id)
    updated_order_data = response_hash['o_array']
    my_order_id = response_hash['my_order_id']
    Resque.logger.info("new product info for subscription(#{subscription_id})'s orders are: #{updated_order_data.inspect}")
    incoming_product_id = params['alt_product_id']
    recharge_change_header = params['recharge_change_header']

    updated_order_data.each do |l_item|
      my_line_item = {
        "properties" => l_item['properties'],
        "quantity" => l_item['quantity'].to_i,
        "sku" => l_item['sku'],
        "title" => l_item['title'],
        "variant_title" => l_item['variant_title'],
        "product_id" => l_item['shopify_product_id'].to_i,
        "variant_id" => l_item['shopify_variant_id'].to_i,
        "subscription_id" => l_item['subscription_id'].to_i,
      }
      updated_line_items.push(my_line_item)
    end

    my_hash = { "line_items" => updated_line_items }
    body = my_hash.to_json
    my_details = { "sku" => new_product.sku,
                   "product_title" => new_product.product_title,
                   "shopify_product_id" => new_product.product_id,
                   "shopify_variant_id" => new_product.variant_id,
                   "properties" => updated_line_items,
                 }
    params = { "subscription_id" => subscription_id, "action" => "switching_product", "details" => my_details }
    # When updating line_items, you need to provide all the data that was in
    # line_items before, otherwise only new parameters will remain! (from Recharge docs)
    my_update_order = HTTParty.put("https://api.rechargeapps.com/orders/#{my_order_id}", :headers => recharge_change_header, :body => body, :timeout => 80)
    Resque.logger.info "MY RECHARGE RESPONSE: #{my_update_order.parsed_response}"

    Resque.logger.debug(my_update_order.inspect)
    # Below for email to customer
    update_success = false
    if my_update_order.code == 200
      my_update_order.parsed_response['order']['line_items'][0]['properties'].each do |item|
        next unless item['name'] == 'product_collection'
        params['product_collection'] = item['value']
      end
      Resque.enqueue(SendEmailToCustomer, params)
      update_success = true
      puts "****** Hooray We have no errors **********"
      Resque.logger.info("****** Hooray We have no errors **********")
    else
      Resque.enqueue(SendEmailToCS, params)
      puts "We were not able to update the subscription"
      Resque.logger.error("We were not able to update the subscription")
    end

  end
end
