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
    #response_hash = provide_current_orders(product_id, subscription_id, new_product.product_id)
    #updated_order_data = response_hash['o_array']
    #my_order_id = response_hash['my_order_id']
    #Resque.logger.info("Order update body [sub_id: #{subscription_id})] going to ReCharge = #{updated_order_data.inspect}")


    #New Code Floyd Wallace 2/11/2020
    Resque.logger.info("Starting order update ... ")
    now = Time.zone.now
    my_new_product = AlternateProduct.find_by_product_id(new_product.product_id)

    sql_query = "SELECT * FROM orders WHERE line_items @> '[{\"subscription_id\": #{subscription_id}}]'
                AND status = 'QUEUED' AND scheduled_at > '#{now.strftime('%F %T')}'
                AND scheduled_at < '#{now.end_of_month.strftime('%F %T')}'
                AND is_prepaid = 1;"
    my_orders = Order.find_by_sql(sql_query)
    #Can have multiple orders somehow in same month belonging to same subscription.
    my_orders.each do |myord|
      Resque.logger.info "updating order_id #{myord.order_id} -- #{my_new_product.product_collection}"
      myord.line_items.first['properties'].each do |prop|
        prop['value'] = my_new_product.product_collection if (prop['name'] == "product_collection")
        
      end
      tops = myord.line_items.first['properties'].select{|x| x['name'] == 'tops'}
      sports_jacket = myord.line_items.first['properties'].select{|x| x['name'] == 'sports-jacket'}
      if sports_jacket == [] && tops != []
        myord.line_items.first['properties'] << { "name" => "sports-jacket", "value" => tops.first['value'].upcase }
      end
      myord.save!
      #Update each order below, with the proper values to ReCharge
      #Now construct line item for sending to ReCharge with various parameters
      price = "0.00"
      if myord.line_items.first.key?('price')
        if myord.line_items.first['price'].to_i > 0
          price = myord.line_items.first['price']
        end
      end

      

      # Recharge line_items endpoint ALPHA as of 11/3/19 stores price as string despite docs
      

      temp_product_id = myord.line_items.first['shopify_product_id'].to_i
      temp_variant_id = myord.line_items.first['shopify_variant_id'].to_i
      temp_title = myord.line_items.first['title']
      
      fixed_order = Array.new
      fixed_order = myord.line_items
      fixed_order[0]['product_id'] = temp_product_id.to_i
      fixed_order[0]['variant_id'] = temp_variant_id.to_i
      fixed_order[0]['price'] = price
      


      #remove shopify_variant_id:
            
      fixed_order[0].tap {|myh| myh.delete('shopify_variant_id')}
      fixed_order[0].tap {|myh| myh.delete('shopify_product_id')}
      fixed_order[0].tap {|myh| myh.delete('images')}

     
      

      Resque.logger.info("Updating order_id #{myord.order_id} and sending to Recharge")
      Resque.logger.info("my_line_item to Recharge = #{fixed_order}")
      

      my_data = { "line_items" => fixed_order }
      order_body = my_data.to_json
      my_details = { "sku" => new_product.sku,
                   "product_title" => new_product.product_title,
                   "shopify_product_id" => new_product.product_id,
                   "shopify_variant_id" => new_product.variant_id,
                   "properties" => fixed_order[0]['properties'],
                 }
      params = { "subscription_id" => subscription_id, "action" => "switching_product", "details" => my_details }
      Resque.logger.info("------")
      Resque.logger.info("sending to ReCharge: #{order_body}")

      my_update_order = HTTParty.put("https://api.rechargeapps.com/orders/#{myord.order_id}", :headers => recharge_change_header, :body => order_body, :timeout => 80)
      Resque.logger.info "RECHARGE ORDER RESPONSE: #{my_update_order.parsed_response}"
      Resque.logger.debug(my_update_order.inspect)

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
end
