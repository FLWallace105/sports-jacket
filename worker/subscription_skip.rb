require_relative 'resque_helper'

class SubscriptionSkip
  extend ResqueHelper
  @queue = 'skip_product'
  def self.perform(params)
    update_success = false
    Resque.logger = Logger.new("#{Dir.getwd}/logs/skip_resque.log")
    puts "Got this: #{params.inspect}"
    #POST /subscriptions/<subscription_id>/set_next_charge_date
    subscription_id = params['subscription_id']
    shopify_customer_id = params['shopify_customer_id']
    my_reason = params['reason']
    my_sub = Subscription.find(subscription_id)
    my_customer = Customer.find_by(shopify_customer_id: shopify_customer_id)
    my_customer_id = my_customer.customer_id


    begin
      my_now = Date.today
      puts my_sub.inspect
      temp_next_charge = my_sub.next_charge_scheduled_at.to_s
      puts temp_next_charge
      #We already push the next_charge_scheduled_at up a month in the main app so now we just need to send to ReCharge.
      #my_next_charge = my_sub.try(:next_charge_scheduled_at).try('+', 1.month)
      my_next_charge = my_sub.try(:next_charge_scheduled_at)
      puts "Now next charge date = #{my_next_charge.inspect}"
      next_charge_str = my_next_charge.strftime("%Y-%m-%d")
      puts "We will change the next_charge_scheduled_at to: #{next_charge_str}"
      recharge_change_header = params['recharge_change_header']
      body = {"date" => next_charge_str}.to_json
      puts "Pushing new charge_date to ReCharge: #{body}"
      my_update_sub = HTTParty.post("https://api.rechargeapps.com/subscriptions/#{subscription_id}/set_next_charge_date", :headers => recharge_change_header, :body => body, :timeout => 80)
      update_success = my_update_sub.success?
      puts my_update_sub.inspect
      apply_skip_tag(shopify_customer_id) if update_success
      #update subscription after skipping so it triggers a webhook event in Reserve Inventory
      my_unique_id = SecureRandom.uuid
      puts "old line item properties = #{my_sub.raw_line_item_properties}"
      my_temp_stuff = my_sub.raw_line_item_properties
      unique_id = my_temp_stuff.select{|x| x['name'] == 'unique_identifier'}
      if unique_id == [] 
        my_temp_stuff << { "name" => "unique_identifier", "value" => unique_id }
      else
        my_temp_stuff.map do |mystuff|
          if mystuff['name'] == 'unique_identifier'
            mystuff['value'] = my_unique_id       
          end
        end
      end
      puts "now updated line item properties = #{my_temp_stuff}"
      stuff_to_recharge = { "properties" => my_temp_stuff }
      body = stuff_to_recharge.to_json

      #my_update_sub = HTTParty.put("https://api.rechargeapps.com/subscriptions/#{my_sub_id}", :headers => 
      #recharge_change_header, :body => body, :timeout => 80)
      #puts my_update_sub.inspect
      #recharge_header = my_update_sub.response["x-recharge-limit"]
      #determine_limits(recharge_header, 0.65)

      #Email results to customer
      new_date = {"date" => next_charge_str}
      params = {"subscription_id" => subscription_id, "action" => "skipping", "details" => new_date }
      puts "params we are sending to SendEmailToCustomer = #{params.inspect}"
      Resque.enqueue(SendEmailToCustomer, params)

      Resque.logger.info(my_update_sub.inspect)
    rescue Exception => e
      #send error email to Customer service
      Resque.enqueue(SendEmailToCS, params)
      Resque.logger.error(e.inspect)
    end

    update_success = true
    puts "****** Hooray We have no errors **********"
    Resque.logger.info("****** Hooray We have no errors **********")
    puts "We are adding to skip_reasons table"
    skip_reason = SkipReason.create(customer_id:  my_customer_id, shopify_customer_id:  shopify_customer_id, subscription_id:  subscription_id, reason:  my_reason, skipped_to:  next_charge_str, skip_status:  update_success, created_at:  my_now )
    puts skip_reason.inspect
    puts "We were not able to update the subscription" unless update_success
    Resque.logger.info("We were not able to update the subscription") unless update_success

  end
end
