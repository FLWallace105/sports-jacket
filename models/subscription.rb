require_relative '../lib/recharge_active_record'
require_relative '../lib/async'


class Subscription < ActiveRecord::Base
  include ApplicationRecord
  include Async

  self.primary_key = :subscription_id

  belongs_to :customer
  has_many :line_items, class_name: 'SubLineItem'
  has_many :order_line_items, class_name: 'OrderLineItemsFixed'
  has_many :orders, through: :order_line_items
  has_and_belongs_to_many :charges, join_table: 'charge_fixed_line_items'

  after_save :update_line_items

  # the options this method takes are:
  # * :time - a valid datetime string / object
  # * :theme_id - the theme the product tag is associated with
  def self.current_products(options = {})
    where(shopify_product_id: ProductTag.active(options).where("tag = ? or tag = ?", 'current', 'prepaid').pluck(:product_id))
  end

  def self.main_product?(sub_id)
    puts "main_product method started"
    my_item = SubLineItem.find_by(
      subscription_id: sub_id,
      name: 'product_collection'
    )
    puts "line_item value found: #{my_item.inspect}"
    puts "return value based on this db query: #{SwitchableProduct.find_by(product_title: my_item.value)}"
    if SwitchableProduct.find_by(product_title: my_item.value)
      return true
    else
      puts "returning false, no switchable record found for product_title: #{my_item.value}"
      return false
    end
  end

  # the options this method takes are:
  # * :time - a valid datetime string / object
  # * :theme_id - the theme the product tag is associated with
  def self.prepaid_products(options = {})
    where(shopify_product_id: ProductTag.active(options).where(tag: 'prepaid').pluck(:product_id))
  end

  # the options this method takes are:
  # * :time - a valid datetime string / object
  # * :theme_id - the theme the product tag is associated with
  def self.skippable_products(options = {})
    where(shopify_product_id: ProductTag.active(options).where(tag: 'skippable').pluck(:product_id))
  end

  # the options this method takes are:
  # * :time - a valid datetime string / object
  # * :theme_id - the theme the product tag is associated with
  def self.switchable_products(options = {})
    switchable_products = ProductTag.active(options)
      .where(tag: 'switchable')
      .pluck(:product_id)
    where(shopify_product_id: switchable_products)
  end

  # Defines the relationship between the local database table and the remote
  # Recharge data format
  def self.api_map
    # helper functions
    identity = ->(x) { x }
    to_s = ->(x) { x.to_s }
    to_i = ->(x) { x.to_i }
    recharge_time = ->(time) { time.try(:strftime, '%FT%T') }
    to_time = ->(str) { str.nil? ? nil : Time.parse(str) }
    to_f = ->(x) { x.to_f }
    [
      {
        remote_key: 'id',
        local_key: 'subscription_id',
        inbound: identity,
        outbound: to_i,
      },
      {
        remote_key: 'address_id',
        local_key: 'address_id',
        inbound: identity,
        outbound: to_i,
      },
      {
        remote_key: 'customer_id',
        local_key: 'customer_id',
        inbound: identity,
        outbound: to_i,
      },
      {
        remote_key: 'created_at',
        local_key: 'created_at',
        inbound: to_time,
        outbound: recharge_time,
      },
      {
        remote_key: 'updated_at',
        local_key: 'updated_at',
        inbound: to_time,
        outbound: recharge_time,
      },
      {
        remote_key: 'next_charge_scheduled_at',
        local_key: 'next_charge_scheduled_at',
        inbound: to_time,
        outbound: recharge_time,
      },
      {
        remote_key: 'cancelled_at',
        local_key: 'cancelled_at',
        inbound: to_time,
        outbound: recharge_time,
      },
      {
        remote_key: 'product_title',
        local_key: 'product_title',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'price',
        local_key: 'price',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'quantity',
        local_key: 'quantity',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'status',
        local_key: 'status',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'shopify_product_id',
        local_key: 'shopify_product_id',
        inbound: identity,
        outbound: to_i,
      },
      {
        remote_key: 'shopify_variant_id',
        local_key: 'shopify_variant_id',
        inbound: identity,
        outbound: to_i,
      },
      {
        remote_key: 'sku',
        local_key: 'sku',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'order_interval_unit',
        local_key: 'order_interval_unit',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'order_interval_frequency',
        local_key: 'order_interval_frequency',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'order_day_of_month',
        local_key: 'order_day_of_month',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'order_day_of_week',
        local_key: 'order_day_of_week',
        inbound: identity,
        outbound: identity,
      },
      {
        remote_key: 'properties',
        local_key: 'raw_line_item_properties',
        inbound: lambda do |p|
          logger.debug "parsing properties: #{p}"
          p || []
        end,
        outbound: identity,
      },
    ].freeze
  end

  # skips the given subscription_id immeadiately
  # returns the updated active record object.
  def self.skip!(subscription_id)
    sub = Subscription.find(subscription_id)
    res = sub.skip
    return unless res[0]
    sub.recharge_update!
  end

  def prepaid?
    ProductTag.active.where(tag: 'prepaid').pluck(:product_id).include? shopify_product_id
  end

  def prepaid_skippable?
    today = Time.zone.now.day
    skip_conditions = [
      prepaid?,
      check_prepaid_orders,
      can_skip_hasnt_switched?,
      today < 5,
    ]
    puts "PREPAID_SKIPPABLE?: prepaid: #{prepaid?}, check_prepaid_orders: #{check_prepaid_orders},"\
    " today < 5: #{today < 5}, can_skip_hasnt_switched?: #{can_skip_hasnt_switched?}"
    skip_conditions.all?
  end

  def prepaid_switchable?
    skip_conditions = [
      prepaid?,
      check_prepaid_orders,
      !prepaid_switched?,
    ]
    puts "PREPAID_SWITCHABLE?: prepaid: #{prepaid?}, check_prepaid_orders: #{check_prepaid_orders},"\
    " is prepaid sub switchable?: #{!prepaid_switched?}"
    skip_conditions.all?
  end

  def active?(time = nil)
    time ||= Time.current
    next_charge_scheduled_at.try('>', time) &&
      status == 'ACTIVE'
  end

  # evaluated options are:
  #   time: the time of the skip action
  #   theme_id: the theme_id for checking appropriate ProductTags

  # if prepaid created at date needs to be at least 1 month in past to day
  # inside skip_conditions
  def skippable?(options = {})
    now = options[:time] || Time.zone.now
    skip_conditions = [
      !prepaid?,
      active?,
      now.day < 5,
      ProductTag.active(options).where(tag: 'skippable')
        .pluck(:product_id).include?(shopify_product_id),
      next_charge_scheduled_at.try('>', now.beginning_of_month),
      next_charge_scheduled_at.try('<', now.end_of_month),
      next_charge_scheduled_at.try('>', now),
    ]
    skip_conditions.all?
  end

  def skip
    return false unless skippable?
    self.next_charge_scheduled_at += 1.month
    save
  end

  #def charges
    #Charge.by_subscription_id subscription_id
  #end

  def next_charge(time = nil)
    time ||= Time.current
    charges.where('scheduled_at > ?', time)
      .order(scheduled_at: :asc)
      .first
  end

  def shipping_at
    next_order = orders.where(status: 'QUEUED')
      .where('scheduled_at > ?', Date.today)
      .order(:scheduled_at)
      .first
    next_order.try(&:scheduled_at)
  end

  def size_line_items
    line_items.where(name: SubLineItem::SIZE_PROPERTIES)
  end

  def sizes
    #returns hash of (size_property and size) key-value pairs with keys as symbols
    raw_line_item_properties
      .select{|p| SubLineItem::SIZE_PROPERTIES.include? p['name']}
      .map{|p| [p['name'], p['value']]}
      .to_h
  end

  #converts line_items hash to symbol keys, merges new sizes, saves resulting hash locally with string keys
  def sizes=(new_sizes)
    prop_hash = raw_line_item_properties.map{|prop| [prop['name'], prop['value']]}.to_h
    merged_hash = prop_hash.merge new_sizes
    self[:raw_line_item_properties] = merged_hash.map{|k, v| {'name' => k, 'value' => v}}
    puts "new subscription(#{subscription_id}) line_items = #{self[:raw_line_item_properties]}"
  end

  # valid options are:
  #   time: the time the switch was made (used for checking company policy)
  #   theme_id: the theme_id used for finding switchable and alternate products
  def switchable?(options = {})
    now = options[:time] || Time.zone.now
    switch_conditions = [
      !prepaid?,
      active?,
      ProductTag.active(options).where(tag: 'switchable')
        .pluck(:product_id).include?(shopify_product_id),
      next_charge_scheduled_at.try('>', now.beginning_of_month),
      next_charge_scheduled_at.try('<', now.end_of_month),
      next_charge_scheduled_at.try('>', now),
    ]
    switch_conditions.all?
  end

  # valid options are:
  #   time: the time the switch was made (used for checking company policy)
  #   theme_id: the theme_id used for finding switchable and alternate products
  def switch_product(new_product_id = nil, options = {})
    return false unless switchable?(options)
    self.shopify_product_id = new_product_id || alt_product_id
    save
  end

  def self.get_alt_product_id(current_product_id)
    Config['alt_products'][current_product_id]
  end

  def alt_product_id
    Subscription.get_alt_product_id product_id
  end

  def current_product?
    ProductTag.active.where(tag: 'current').pluck(:product_id).include? shopify_product_id
  end

  def get_order_props
    mon_end = Time.zone.today.end_of_month
    sql_query = "SELECT * FROM orders WHERE line_items @> '[{\"subscription_id\": #{subscription_id}}]'
                AND scheduled_at <= '#{mon_end.strftime('%F %T')}'
                AND status = 'QUEUED' AND is_prepaid = 1;"
    my_orders = Order.find_by_sql(sql_query)
    puts "queued orders this month for sub: #{subscription_id} =====>  #{my_orders.inspect}"

    if my_orders.empty? == false
      my_orders.each do |order|
        if order.scheduled_at >= Date.today.strftime('%F %T')
          @my_res = line_item_parse(order)
        end
      end
      return @my_res
    else
      return false
    end
  end

  def current_order_data
    sql_query = "select  * from orders where line_items @>"\
    " '[{\"subscription_id\": #{subscription_id}}]' and status = 'SUCCESS'"\
    " and is_prepaid = 0 and scheduled_at = '#{Date.today.strftime('%F %T')}' ORDER BY (scheduled_at) DESC"

    my_order = Order.find_by_sql(sql_query).first
    puts "++++current_order_data = #{my_order.inspect}"
    my_title = ""
    my_date = ""
    begin
      my_order.line_items.each do |item|
        next unless item["subscription_id"].to_s == subscription_id
        item["properties"].each do |prop|
          next unless prop["name"] == "product_collection"
          my_title = prop["value"]
        end
        if all_orders_sent?(subscription_id)
          my_date = next_charge_scheduled_at
        else
          my_date = my_order.shipping_date
        end
      end
    rescue StandardError => e
      # handles edge cases where all orders not recieved and no order scheduled today
      puts "Current order not found for subscription_id: #{subscription_id}"
      my_item = SubLineItem.find_by(
        subscription_id: subscription_id,
        name: 'product_collection'
      )
      return {
          my_title: my_item.value,
          ship_date: next_charge_scheduled_at,
        }
    end
    return {
        my_title: my_title,
        ship_date: my_date,
      }
  end

  # private

  def update_line_items
    return unless saved_change_to_attribute? :raw_line_item_properties
    Subscription.transaction do
      raw_line_item_properties.each do |prop|
        sub = SubLineItem.find_or_create_by(
          subscription_id: subscription_id,
          name: prop[:name],
        )
        sub.value = prop[:value]
        sub.save!
      end
    end
  end

  # Internal: Parse order arguements line_items
  #
  # order - Order type object that represents subscriptions
  # next queued order for this month
  #
  # Returns hash containing actual product title
  # since prepaid orders parent data is the 3-Month "wrapper:" product
  # and order shipping date or returns the orders first line_item's hash data.
  def line_item_parse(order)
    if order.line_items.kind_of?(String)
      my_line_item_hash = JSON.parse(order.line_items)
      # for edge cases where order_pull rake task saved line_items as a String type
    else
      my_line_item_hash = order.line_items
    end
    my_line_item_hash.each do |item|
      puts "SUB ID IN LINE_ITEM_PARSE: #{subscription_id} , class = #{subscription_id.class}\n\n"
      puts "item['subscription_id'] =#{item['subscription_id']} , sub_id param=#{subscription_id} match?: #{item['subscription_id'].to_s == subscription_id}"
      if item['properties'].empty? == false
        item['properties'].each do |prop|
          if prop['name'] == "product_collection" && item['subscription_id'].to_s == subscription_id
            return {
             my_title: prop['value'],
             ship_date: order.shipping_date,
            }
          end
        end
      else
        return {
          my_title: order.line_items[0]["title"],
          ship_date: order.shipping_date,
        }
      end
    end
  end

  # Internal: Query for queued orders scheduled to ship this month.
  #
  # Returns boolean based on whether or not subscription has
  # an associated order with a status="QUEUED" shipping this month after today.
  def check_prepaid_orders
    now = Time.zone.now
    sql_query = "SELECT * FROM orders WHERE
                line_items @> '[{\"subscription_id\": #{subscription_id}}]'
                AND status = 'QUEUED'
                AND scheduled_at > '#{Date.today.to_time.strftime('%F %T')}'
                AND scheduled_at < '#{now.end_of_month.strftime('%F %T')}'
                AND is_prepaid = 1;"
    this_months_orders = Order.find_by_sql(sql_query)
    order_check = false
    puts this_months_orders.inspect
    if this_months_orders != []
      this_months_orders.each do |order|
        if order.scheduled_at > now.strftime('%F %T')
          order_check = true
          break
        end
      end
    elsif all_orders_sent?(subscription_id)
      puts "no queued orders found for sub: #{subscription_id}, all orders sent!"
      order_check = true
    end
    return order_check
  end

  # Internal: Validate whether a subscription can switch this month
  #
  # Returns a boolean value where true means customer cant switch
  # and false means they cannot switch.
  def prepaid_switched?(options = {})
    now = Time.zone.now
    options[:time] = now

    sql_query = "SELECT * FROM orders WHERE line_items @> '[{\"subscription_id\": #{subscription_id}}]'
                AND status = 'QUEUED' AND scheduled_at > '#{now.beginning_of_month.strftime('%F %T')}'
                AND scheduled_at < '#{now.end_of_month.strftime('%F %T')}'
                AND is_prepaid = 1;"
    this_months_orders = Order.find_by_sql(sql_query)
    switched_this_month = true

    if this_months_orders != []
      this_months_orders.each do |order|
        order.line_items.each do|item|
          if item["subscription_id"].to_s == subscription_id
            item["properties"].each do |prop_hash|
              @product_name = prop_hash["value"] if prop_hash["name"] == "product_collection"
            end
          end
        end
        order_prod_id = Product.find_by(title: @product_name).shopify_id
        if ProductTag.active(options).where(tag: 'switchable')
          .pluck(:product_id).include?(order_prod_id.to_s) &&
          ProductTag.active(options).where(tag: 'current')
            .pluck(:product_id).include?(order_prod_id.to_s)
          switched_this_month = false
        end
      end
    elsif all_orders_sent?(subscription_id)
      return false
    end
    puts "================Is prepaid sub switchable? = #{!switched_this_month}"
    return switched_this_month
  end

  # Internal: Validate whether a subscription can skip this month.
  #
  # Returns a boolean value where true means customer can skip
  # and false means they cannot skip.
  def can_skip_hasnt_switched?(options = {})
    now = Time.zone.now
    end_of_Month = Time.now.end_of_month.strftime('%F %T')
    options[:time] = now
    sql_query = "SELECT * FROM orders WHERE line_items @> '[{\"subscription_id\": #{subscription_id}}]'
                AND status = 'QUEUED' AND scheduled_at > '#{now.beginning_of_month.strftime('%F %T')}'
                AND scheduled_at < '#{end_of_Month}'
                AND is_prepaid = 1;"
    this_months_orders = Order.find_by_sql(sql_query)
    can_skip = false

    if this_months_orders.any?
      this_months_orders.each do |order|
        order.line_items.each do|item|
          if item["subscription_id"].to_s == subscription_id
            item["properties"].each do |prop_hash|
              @product_name = prop_hash["value"] if prop_hash["name"] == "product_collection"
            end
          end
        end

        order_prod_id = Product.find_by(title: @product_name).shopify_id
        if ProductTag.active(options).where(tag: 'skippable')
          .pluck(:product_id).include?(order_prod_id.to_s) &&
          ProductTag.active(options).where(tag: 'current')
            .pluck(:product_id).include?(order_prod_id.to_s)
          can_skip = true
        end
      end
    elsif all_orders_sent?(subscription_id)
      today = Date.today.strftime('%F %T')
      puts "#{end_of_Month}"
      if (next_charge_scheduled_at > today) && (next_charge_scheduled_at <= end_of_Month)
        can_skip = true
      end
    end
    puts "==============Can skip and hasnt switched? = #{can_skip}"
    return can_skip
  end

  # Internal: query number of orders with status=QUEUED and scheduled_at > 1 week ago for
  # added independency incase order is delayed
  #
  # returns true if subscription has no queued orders and next_charge_scheduled_at is > today
  def all_orders_sent?(sub_id)
    sql_query = "SELECT * FROM orders WHERE
                  line_items @> '[{\"subscription_id\": #{sub_id}}]'
                  AND status = 'QUEUED' AND scheduled_at > '#{Date.today.strftime('%F %T')}';"
    upcoming_orders = Order.find_by_sql(sql_query)
    if next_charge_scheduled_at >= Date.today.strftime('%F %T') && upcoming_orders.empty?
      puts "all_orders_sent? = TRUE"
      return true
    else
      puts "all_orders_sent? = FALSE"
      return false
    end
  end

end
