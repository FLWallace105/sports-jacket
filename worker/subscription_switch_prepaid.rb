require_relative 'resque_helper'

class SubscriptionSwitchPrepaid
  extend ResqueHelper
  @queue = "switch_product"

  def self.perform(params)
    puts params.inspect
    Resque.logger = Logger.new("#{Dir.getwd}/logs/prepaid_switch_resque.log")
    updated_line_items = []

    subscription_id = params['subscription_id']
    product_id = params['product_id'] # 3 MONTHS product etc...
    new_product = AlternateProduct.find_by_product_id(params['real_alt_product_id'])
    recharge_change_header = params['recharge_change_header']

    Resque.logger.info "my new product id : #{new_product.product_id}"
    Resque.logger.info("We are working on subscription #{subscription_id}")

    #---START subscription Recharge API update---#
    # 9/5/19 requested code change where sub product_collection updates on
    # all prepaid switch requests, not just 'no queued order' subs.
    new_line_items = provide_sub_update_body(product_id, new_product.product_id, subscription_id)
    sub_body = new_line_items['recharge'].to_json
    Resque.logger.info "Subscription update body going to ReCharge = #{sub_body.inspect}"
    sub_update_success = false

    my_update_sub = HTTParty.put(
      "https://api.rechargeapps.com/subscriptions/#{subscription_id}",
      :headers => recharge_change_header, :body => sub_body, :timeout => 80
    )
    Resque.logger.info "RECHARGE SUBSCRPTION UPDATE RESPONSE CODE: #{my_update_sub.code}"
    Resque.logger.info "RECHARGE SUBSCRIPTION RESPONSE: #{my_update_sub.inspect}"

    sub_update_success = true if my_update_sub.code == 200
    #---END subscription Recharge API update---#

    #---START order Recharge API update---#
    response_hash = provide_current_orders(product_id, subscription_id, new_product.product_id)
    updated_order_data = response_hash['o_array']
    my_order_id = response_hash['my_order_id']
    Resque.logger.info("Order update body [sub_id: #{subscription_id})] going to ReCharge = #{updated_order_data.inspect}")

    updated_order_data.each do |l_item|
      my_line_item = {
        "properties" => l_item['properties'],
        "quantity" => l_item['quantity'].to_i,
        "price" => l_item['price'].to_i,
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
    order_body = my_hash.to_json
    my_details = { "sku" => new_product.sku,
                   "product_title" => new_product.product_title,
                   "shopify_product_id" => new_product.product_id,
                   "shopify_variant_id" => new_product.variant_id,
                   "properties" => updated_line_items,
                 }
    params = { "subscription_id" => subscription_id, "action" => "switching_product", "details" => my_details }
    # When updating line_items, you need to provide all the data that was in
    # line_items before, otherwise only new parameters will remain! (from Recharge docs)
    my_update_order = HTTParty.put("https://api.rechargeapps.com/orders/#{my_order_id}", :headers => recharge_change_header, :body => order_body, :timeout => 80)
    Resque.logger.info "RECHARGE ORDER RESPONSE: #{my_update_order.parsed_response}"
    Resque.logger.debug(my_update_order.inspect)
    #---END order Recharge API update---#

    # Below for email to customer
    if my_update_order.code == 200 && my_update_sub.code == 200
      my_update_order.parsed_response['order']['line_items'][0]['properties'].each do |item|
        next unless item['name'] == 'product_collection'
        params['product_collection'] = item['value']
      end
      Resque.enqueue(SendEmailToCustomer, params)
      Resque.logger.info("****** Hooray We have no errors **********")
    else
      Resque.enqueue(SendEmailToCS, params)
      Resque.logger.error("We were not able to update the subscription/orders")
    end

  end
end
