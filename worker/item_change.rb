require_relative 'resque_helper'

class ItemChange
  extend ResqueHelper
  @queue = "item_change"

  def self.perform(params)
    puts params.inspect
    Resque.logger = Logger.new("#{Dir.getwd}/logs/item_change.log")
    subscription_id = params['subscription_id']
    new_product_id = params['real_alt_product_id']
    new_product_collection = params['product_collection']
    puts "new product id recieved #{new_product_id}"
    puts "We are working on subscription #{subscription_id}"

    Resque.logger.info("We are working on subscription #{subscription_id}")
    temp_hash = generate_change_data(new_product_id, subscription_id, new_product_collection)
    puts temp_hash.inspect

    Resque.logger.info("new product info for subscription #{subscription_id}: #{temp_hash}")
    recharge_change_header = params['recharge_change_header']
    body = temp_hash.to_json
    puts body

    # TODO(Neville): Add new email block in SendEmailToCustomer an SendEmailToCS
    params = {"subscription_id" => subscription_id, "action" => "change_subscription", "details" => temp_hash   }
    my_update_sub = HTTParty.put("https://api.rechargeapps.com/subscriptions/#{subscription_id}", :headers => recharge_change_header, :body => body, :timeout => 80)
    puts my_update_sub.inspect
    Resque.logger.info("RECHARGE RESPONSE: #{my_update_sub.inspect}")

    #Below for email to customer
    if my_update_sub.code == 200
      Resque.enqueue(SendEmailToCustomer, params)
      puts "****** Hooray We have no errors **********"
      Resque.logger.info("****** Hooray We have no errors **********")
    else
      Resque.enqueue(SendEmailToCS, params)
      puts "We were not able to update the subscription"
      Resque.logger.info("We were not able to [up/down]grade the subscription")
    end
  end


end
