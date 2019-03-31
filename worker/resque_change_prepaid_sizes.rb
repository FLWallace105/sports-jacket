require_relative 'resque_helper'

class ChangePrepaidSizes
  @recharge_token = ENV['RECHARGE_ACCESS_TOKEN']
  @recharge_change_header = {
    'X-Recharge-Access-Token' => @recharge_token,
    'Accept' => 'application/json',
    'Content-Type' => 'application/json'
  }
  extend ResqueHelper
  @queue = 'change_prepaid_sizes'

  def self.perform(subscription_id, new_sizes)
    Resque.logger = Logger.new("#{Dir.getwd}/logs/size_change_prepaid_resque.log")
    sub = Subscription.find subscription_id
    Resque.logger.info(sub.inspect)
    # Update subscription through REcharge api (propriatary method used)
    sub_litems = {"properties" => sub.raw_line_item_properties}.to_json
    res1 = HTTParty.put("https://api.rechargeapps.com/subscriptions/#{subscription_id}", :headers => @recharge_change_header, :body => sub_litems, :timeout => 80)
    Resque.logger.info(res1.inspect)
    sub.save! if res1.code ==200

    queued_orders = Order.where("line_items @> ? AND status = ? AND is_prepaid = ?", [{subscription_id: subscription_id.to_i}].to_json, "QUEUED", 1)
    Resque.logger.info("QUEUED_ORDERS found in ChangePrepaidSizes worker: #{queued_orders.inspect}")
    all_clear = true
    # Iterate through queued orders for sub_id argument and update through REcharge api
    queued_orders.each do |my_order|
      my_order.sizes_change(new_sizes, subscription_id)
      Resque.logger.info("Order: #{my_order.order_id} sizes are now #{my_order.sizes(subscription_id)}")
      my_hash = { "line_items" => reformat_oline_items(my_order.line_items) }
      body = my_hash.to_json
      Resque.logger.info "my hash: #{body.inspect}"
      @res = HTTParty.put("https://api.rechargeapps.com/orders/#{my_order.order_id}", :headers => @recharge_change_header, :body => body, :timeout => 80)
      Resque.logger.info @res
      my_order.save! if (@res.code == 200)
      all_clear = false if (@res.code != 200)
    end

    params = {"subscription_id" => subscription_id, "action" => "change_sizes", "details" => new_sizes  }

    if all_clear
      Resque.enqueue(SendEmailToCustomer, params)
    else
      Resque.enqueue(SendEmailToCS, params)
    end
    puts 'Sizes updated!'
  end
end
