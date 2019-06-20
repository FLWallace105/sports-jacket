require_relative 'resque_helper'

class PrepaidCollectionSwitch
  extend ResqueHelper
  @queue = "switch_collection"
  def self.perform(params)
    puts params.inspect
    Resque.logger = Logger.new("#{Dir.getwd}/logs/prepaid_switch_resque.log")

    #{"action"=>"switch_product", "subscription_id"=>"8672750", "product_id"=>"8204555081"}
    subscription_id = params['subscription_id']
    incoming_product_id = params['alt_product_id']
    puts "We are working on subscription #{subscription_id}"
    Resque.logger.info("We are working on subscription #{subscription_id}")
    my_item = SubLineItem.find_by(
      subscription_id: subscription_id,
      name: 'product_collection'
    )
    product_id = Product.find_by_title(my_item['value']).shopify_id
    Resque.logger.info(product_id)
    #Here is where we do some things that make sure we only push the product_collection changes to
    #the ReCharge endpoint for the prepaid subscription where there is no queued orders as the card
    #has not yet charged
    hash_array = provide_no_queued_info(product_id, incoming_product_id, subscription_id)
    puts hash_array['email_info']
    Resque.logger.info("new product info for subscription #{subscription_id} is #{hash_array['email_info']}")
    recharge_change_header = params['recharge_change_header']
    puts recharge_change_header
    body = hash_array['recharge'].to_json
    puts body
    Resque.logger.info "++++++++++++++++++++++ body = #{body.inspect}"
    #Below for email to customer
    params = { "subscription_id" => subscription_id,
              "action" => "switching_product",
              "details" => hash_array['email_info']
    }
    my_update_sub = HTTParty.put(
      "https://api.rechargeapps.com/subscriptions/#{subscription_id}",
      :headers => recharge_change_header, :body => body, :timeout => 80
    )
    puts my_update_sub.inspect

    Resque.logger.info(my_update_sub.inspect)

    update_success = false
    if my_update_sub.code == 200
      my_update_sub.parsed_response['subscription']['properties'].each do |prop|
        puts "MY PROP: #{prop}"
        next unless prop['name'] == 'product_collection'
        params['product_collection'] = prop['value']
      end
      Resque.enqueue(SendEmailToCustomer, params)
      #if 200 == 200
      update_success = true
      puts "****** Hooray We have no errors **********"
      Resque.logger.info("****** Hooray We have no errors **********")
    else
      Resque.enqueue(SendEmailToCS, params)
      puts "We were not able to update the subscription"
      Resque.logger.info("We were not able to update the subscription")
    end


  end
end
