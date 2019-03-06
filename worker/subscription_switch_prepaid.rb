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
    my_variant = EllieVariant.find_by(product_id: product_id)
    new_product_id = AlternateProduct.find_by_product_id(params['real_alt_product_id']).product_id
    new_product = Product.find_by(shopify_id: new_product_id)
    incoming_product_id = params['alt_product_id']
    recharge_change_header = params['recharge_change_header']

    puts "We are working on subscription #{subscription_id}"
    Resque.logger.info "my new product id : #{new_product_id}"

    # UPDATE SUBSCRIPTION
    Resque.logger.info("We are working on subscription #{subscription_id}")
    my_item = SubLineItem.find_by(
      subscription_id: subscription_id,
      name: 'product_collection'
    )
    current_product_id = Product.find_by_title(my_item['value']).shopify_id
    hash_array = provide_no_queued_info(current_product_id, incoming_product_id, subscription_id)
    sub_body = hash_array['recharge'].to_json
    puts "subscription switch prepaid request Body = #{sub_body.inspect}"
    Resque.logger.info "subscription switch prepaid request Body = #{sub_body.inspect}"
    my_update_sub = HTTParty.put(
      "https://api.rechargeapps.com/subscriptions/#{subscription_id}",
      :headers => recharge_change_header, :body => sub_body, :timeout => 80
    )
    puts my_update_sub.inspect
    Resque.logger.info("Recharge sub update response: #{my_update_sub.inspect}")
    # END OF UPDATE SUBSCRIPTION

    # UPDATE QUEUED ORDERS
    response_hash = provide_current_orders(product_id, subscription_id, new_product_id)
    updated_order_data = response_hash['o_array']
    my_order_id = response_hash['my_order_id']
    Resque.logger.info("new product info for subscription(#{subscription_id})'s orders are: #{updated_order_data.inspect}")

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
    my_details = { "sku" => my_variant.sku,
                   "product_title" => Product.find_by(shopify_id: product_id).title,
                   "shopify_product_id" => product_id,
                   "shopify_variant_id" => my_variant.variant_id,
                   "properties" => updated_line_items,
                 }
    params = { "subscription_id" => subscription_id, "action" => "switching_product", "details" => my_details }
    # When updating line_items, you need to provide all the data that was in
    # line_items before, otherwise only new parameters will remain! (from Recharge docs)
    my_update_order = HTTParty.put("https://api.rechargeapps.com/orders/#{my_order_id}", :headers => recharge_change_header, :body => body, :timeout => 80)
    Resque.logger.info "MY RECHARGE RESPONSE: #{my_update_order.parsed_response}"
    # END OF UPDATE ORDERS

    Resque.logger.debug(my_update_order.inspect)
    # Below for email to customer
    update_success = false
    if my_update_order.code == 200
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
