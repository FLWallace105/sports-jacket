require 'csv'

module ShortShip
  def self.generate
    today = Time.now.strftime('%F %T')
    four_months = (Date.today >> 4).end_of_month.strftime('%F %T')
    puts "FOUR MONTHS: #{four_months}"
    month_end = Time.now.end_of_month.strftime('%F %T')
    upcoming_subs = Subscription.find_by_sql(
      "SELECT * FROM subscriptions where (next_charge_scheduled_at > '#{today}' AND
      next_charge_scheduled_at <= '#{four_months}' AND status='ACTIVE' AND
      product_title ilike '%Summer%') OR (next_charge_scheduled_at > '#{today}' AND
      next_charge_scheduled_at <= '#{four_months}' AND status='ACTIVE' AND product_title ilike '%month%') ORDER BY next_charge_scheduled_at ASC"
    )
    puts "active subs shipping this month: #{upcoming_subs.count}" #585
    inventory = {
      "tops" => {'XS'=> 0, 'S' => 65, 'M' => 330, 'L' => 400, 'XL' => 185, 'item' => 'Tonya Tank-Eclipse'},
      "sports-bra" => {'XS' => 70,'S' => 80, 'M' => 120, 'L' => 150, 'XL' => 95, 'item' => 'Dani Mesh Sports Bra-Black'},
      "leggings" => {'XS' => 0,'S' => 50, 'M' => 180, 'L' => 290, 'XL' => 160, 'item' => 'Jaime Run Short-Black'},
    }
    short_customers = []
    true_sorting_list = []
    top_count = ''
    legging_count = ''
    sports_bra_count = ''

    # sort subs and prepaids for inventory(order.scheduled_at & sub.next_charge_scheduled_at)
    puts "first loop started..."
    upcoming_subs.each do |sub|
      order_res = self.prepaid_this_month(sub.subscription_id)
      not_found = true
      if sub.charge_interval_frequency == 3 && order_res[:order_check]
        props = sub.raw_line_item_properties.map{|p| [p['name'], p['value']]}.to_h
        if props['product_collection'].include?("Feels Like Summer")
          puts "PREPAID SHIPPING THIS MONTH"
          true_sorting_list << {'sub_id': sub.subscription_id, 'cust_id': sub.customer_id, 'ship_date': order_res[:ship_date]}
          not_found = false
        end
      end
      # skip reg subs that ship next month
      if sub.next_charge_scheduled_at > month_end && sub.charge_interval_frequency == 1
        next
      # skip prepaids that dont have queued orders this month
      elsif sub.charge_interval_frequency == 3 && !(self.prepaid_this_month(sub.subscription_id))
        next
      end

      true_sorting_list << {'sub_id': sub.subscription_id, 'cust_id': sub.customer_id, 'ship_date': sub.next_charge_scheduled_at} if not_found
    end
    puts "first loop done!"

    puts "sorting now.."
    true_sorting_list.sort_by! do |obj|
      obj[:ship_date]
    end
    puts "inventory check starting.."
    true_sorting_list.each do |obj|
      sub = Subscription.find(obj[:sub_id])
      # return hash of sizes {"leggings" => 'M',...}
      sizes = sub.sizes
      puts "sub: #{obj[:sub_id]}"
      puts "sizes: #{sizes}"
      # decrement tops
      top_count = inventory['tops'][sizes['tops'].upcase]
      inventory['tops'][sizes['tops'].upcase] = top_count - 1
      # decrement sports-bras
      sports_bra_count = inventory['sports-bra'][sizes['sports-bra'].upcase]
      inventory['sports-bra'][sizes['sports-bra'].upcase] = sports_bra_count - 1
      # decrement leggings
      legging_count = inventory['leggings'][sizes['leggings'].upcase]
      inventory['leggings'][sizes['leggings'].upcase] = legging_count - 1

      # track shorted customers w/ item:size
      missing = ''
      short = false

      if top_count < 1
        missing << "#{inventory['tops']['item']}:#{sizes['tops']}, "
        short = true
      end

      if sports_bra_count < 1
        missing << "#{inventory['sports-bra']['item']}:#{sizes['sports-bra']}, "
        short = true
      end

      if legging_count < 1
        missing << "#{inventory['leggings']['item']}:#{sizes['leggings']}, "
        short = true
      end

      if short
        short_customers << {'customer_id': obj[:cust_id],
          'missing': missing,
          'sub_id': obj[:sub_id],
          'ship_date': obj[:ship_date],
        }
      end
    end
    puts "inventory loop done!"
    puts short_customers.size
    # short_customers.each do |cust|
    #   puts cust[:missing]
    # end
    #Headers for CSV
    column_header = [
      "subscription_id", "customer_id", "shopify_customer_id",
      "ship_date",
      "product_title", "first_name", "last_name", "email", "short_items"
    ]
    #delete old file
    File.delete('short_customers.csv') if File.exist?('short_customers.csv')
    CSV.open('short_customers.csv','a+', :write_headers=> true, :headers => column_header) do |hdr|
        column_header = nil

    short_customers.each do |short|
      cust = Customer.find(short[:customer_id])
      sub = Subscription.find(short[:sub_id])
        #Construct the CSV string
        subscription_id = sub.subscription_id
        customer_id = cust.customer_id
        shopify_customer_id = cust.shopify_customer_id
        ship_date = short[:ship_date]
        product_title = sub.product_title
        first_name = cust.first_name
        last_name = cust.last_name
        email = cust.email
        short_items = short[:missing]
        csv_data_out = [subscription_id, customer_id, shopify_customer_id, ship_date, product_title, first_name, last_name, email, short_items ]
        hdr << csv_data_out
    end
    #end of csv part
    end
  end

  def self.prepaid_this_month(sub_id)
    now = Time.zone.now
    sql_query = "SELECT * FROM orders WHERE
                line_items @> '[{\"subscription_id\": #{sub_id}}]'
                AND status = 'QUEUED'
                AND scheduled_at > '#{now.beginning_of_month.strftime('%F %T')}'
                AND scheduled_at < '#{now.end_of_month.strftime('%F %T')}'
                AND is_prepaid = 1;"
    this_months_orders = Order.find_by_sql(sql_query)
    order_check = false
    ship_date = ''
    # puts this_months_orders.inspect
    if this_months_orders != []
      this_months_orders.each do |order|
        if order.scheduled_at > now.strftime('%F %T')
          order_check = true
          ship_date = order.scheduled_at
          break
        end
      end
    end
    return { 'order_check': order_check, 'ship_date': ship_date }
  end
end
