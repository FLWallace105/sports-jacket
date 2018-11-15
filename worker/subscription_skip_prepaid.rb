require_relative 'resque_helper'

class SubscriptionSkipPrepaid
  extend ResqueHelper
  @queue = 'skip_product_prepaid'
  def self.perform(params)
    Resque.logger = Logger.new("#{Dir.getwd}/logs/prepaid_skip_resque.log")
    logger.info "Got this: #{params.inspect}"
    # PUTS /subscription_skip
    sub_id = params['subscription_id']
    shopify_customer_id = params['shopify_customer_id']
    my_reason = params['reason']
    my_customer = Customer.find_by(shopify_customer_id: shopify_customer_id)
    recharge_customer_id = my_customer.customer_id
    recharge_change_header = params['recharge_change_header']
    orders = HTTParty.get("https://api.rechargeapps.com/orders?subscription_id=#{sub_id}&status=QUEUED", :headers => recharge_change_header, :timeout => 80)
    queued_orders = orders.parsed_response['orders']

    #update parent subscription next_charge_scheduled_at
    begin
      my_sub = Subscription.find(sub_id)
      puts my_sub.inspect
      temp_next_charge = my_sub.next_charge_scheduled_at.to_s
      puts temp_next_charge
      #We already push the next_charge_scheduled_at up a month in the main app so now we just need to send to ReCharge.
      my_next_charge = my_sub.try(:next_charge_scheduled_at)
      puts "Now next charge date = #{my_next_charge.inspect}"
      next_charge_str = my_next_charge.strftime("%Y-%m-%d")
      puts "We will change the next_charge_scheduled_at to: #{next_charge_str}"
      sub_body = {"date" => next_charge_str}.to_json
      puts "Pushing new charge_date to ReCharge: #{sub_body}"
      # add unique id subscription props to push to recharge and trigger update
      # so new next_charge_date value is pulled into db by cronjob
      found_unique_id = false
      my_unique_id = SecureRandom.uuid

      my_sub.raw_line_item_properties.map do |mystuff|
        if mystuff['name'] == 'unique_identifier'
          mystuff['value'] = my_unique_id
          found_unique_id = true
        end
      end

      if found_unique_id == false
        Resque.logger.info "We are adding the unique_identifier to the line item properties"
        my_sub.raw_line_item_properties << { "name" => "unique_identifier", "value" => my_unique_id }
      end

      my_line_items = my_sub.raw_line_item_properties
      sub_body2 = { "properties" => my_line_items }.to_json
      Resque.logger.debug "line_items with uuid: #{sub_body2}"
      sleep 2
      my_update_sub = HTTParty.post("https://api.rechargeapps.com/subscriptions/#{sub_id}/set_next_charge_date", :headers => recharge_change_header, :body => sub_body, :timeout => 80)
      my_update_sub2 = HTTParty.put("https://api.rechargeapps.com/subscriptions/#{sub_id}", :headers => recharge_change_header, :body => sub_body2, :timeout => 80)
      Resque.logger.info "update2 success = #{my_update_sub2.inspect}"
      update_success = my_update_sub.success? && my_update_sub2.success?
      puts my_update_sub.inspect
      Resque.logger.info(my_update_sub.inspect)

      my_now = Date.today
      puts "****** Hooray We have no subcription errors **********"
      Resque.logger.info("****** Hooray We have no subscription errors **********")
      puts "We are adding to skip_reasons table"
      skip_reason = SkipReason.create(customer_id:  recharge_customer_id, shopify_customer_id:  shopify_customer_id, subscription_id:  sub_id, reason:  my_reason, skipped_to: next_charge_str, skip_status:  update_success, created_at:  my_now )
      puts skip_reason.inspect
      puts "We were not able to update the subscription" unless update_success
      Resque.logger.info("We were not able to update the subscription") unless update_success

    # update all queued orders scheduled_at date
      queued_orders.each do |order|
        Resque.logger.info("order id: #{order['id']}")
        temp_datetime = order['scheduled_at'].to_datetime
        Resque.logger.debug("scheduled_at BEFORE skip: #{temp_datetime.inspect}")
        new_datetime = temp_datetime >> 1
        Resque.logger.debug("scheduled_at AFTER skip: #{new_datetime.inspect}")
        @new_scheduled_at_str = new_datetime.strftime("%FT%T")
        body = {"scheduled_at" => @new_scheduled_at_str}.to_json
        puts "Pushing new scheduled_at date to ReCharge: #{body}"
        @my_update_order = HTTParty.post("https://api.rechargeapps.com/orders/#{order['id']}/change_date", :headers => recharge_change_header, :body => body, :timeout => 80)
        update_success = @my_update_order.success?
        Resque.logger.debug(@my_update_order.inspect)
      end
      apply_skip_tag(shopify_customer_id) if update_success

      #Email results to customer
      new_date = {"date" => next_charge_str}
      params = {"subscription_id" => sub_id, "action" => "skipping", "details" => new_date   }
      puts "params we are sending to SendEmailToCustomer = #{params.inspect}"
      Resque.enqueue(SendEmailToCustomer, params)
      Resque.logger.debug(@my_update_order.inspect)

    rescue Exception => e
      #send error email to Customer service
      Resque.enqueue(SendEmailToCS, params)
      Resque.logger.error(e.inspect)
    end

  end
end
