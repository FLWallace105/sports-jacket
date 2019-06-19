#background_orders_partial.rb


require_relative '../lib/recharge_limit'

module PartialBackgroundOrders
    include ReChargeLimits

    def twenty_five_min
        min_ago = 25
        minutes_ago = DateTime.now.in_time_zone - (min_ago/1440.0)
        puts "running configure timezone: #{Time.zone.inspect}"
        #minutes_ago.in_time_zone('Pacific Time (US & Canada)')
        twenty_five_minutes_ago_str = minutes_ago.strftime("%Y-%m-%dT%H:%M:%S")
        puts "Twenty five minutes ago = #{twenty_five_minutes_ago_str}"
        Resque.logger.info "Twenty five minutes ago = #{twenty_five_minutes_ago_str}"
        return twenty_five_minutes_ago_str

    end


    def get_background_partial_orders(params)
        puts params.inspect
        uri = params['uri']
        my_header = params["headers"]
        twenty_five_minutes_ago_str = twenty_five_min

        puts "Here twenty_five_minutes_ago_str = #{twenty_five_minutes_ago_str}"

        orders_count = HTTParty.get("https://api.rechargeapps.com/orders/count?updated_at_min=\'#{twenty_five_minutes_ago_str}\'", :headers => my_header)

        my_response = orders_count
        my_count = my_response['count'].to_i
        puts my_count


        myuri = URI.parse(uri)
        conn =  PG.connect(myuri.hostname, myuri.port, nil, nil, myuri.path[1..-1], myuri.user, myuri.password)

        my_insert = "insert into orders (order_id, transaction_id, charge_status, payment_processor, address_is_active, status, order_type, charge_id, address_id, shopify_id, shopify_order_id, shopify_order_number, shopify_cart_token, shipping_date, scheduled_at, shipped_date, processed_at, customer_id, first_name, last_name, is_prepaid, created_at, updated_at, email, line_items, total_price, shipping_address, billing_address) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28) ON CONFLICT (order_id) DO UPDATE SET charge_status = EXCLUDED.charge_status, payment_processor = EXCLUDED.payment_processor, address_is_active = EXCLUDED.address_is_active, status = EXCLUDED.status, order_type = EXCLUDED.order_type, charge_id = EXCLUDED.charge_id, address_id = EXCLUDED.address_id, shopify_id = EXCLUDED.shopify_id, shopify_order_id = EXCLUDED.shopify_order_id, shopify_order_number = EXCLUDED.shopify_order_number, shopify_cart_token = EXCLUDED.shopify_cart_token, shipping_date = EXCLUDED.shipping_date, scheduled_at = EXCLUDED.scheduled_at, shipped_date = EXCLUDED.shipped_date, processed_at = EXCLUDED.processed_at, customer_id = EXCLUDED.customer_id, first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name, is_prepaid = EXCLUDED.is_prepaid, created_at = EXCLUDED.created_at, updated_at = EXCLUDED.updated_at, email = EXCLUDED.email, line_items = EXCLUDED.line_items, total_price = EXCLUDED.total_price, shipping_address = EXCLUDED.shipping_address, billing_address = EXCLUDED.billing_address "
        conn.prepare('statement1', "#{my_insert}")

        my_order_line_fixed_insert = "insert into order_line_items_fixed (order_id, shopify_variant_id, title, variant_title, subscription_id, quantity, shopify_product_id, product_title) values ($1, $2, $3, $4, $5, $6, $7, $8) ON CONFLICT (order_id) DO UPDATE SET shopify_variant_id = EXCLUDED.shopify_variant_id, title = EXCLUDED.title, variant_title = EXCLUDED.variant_title, subscription_id = EXCLUDED.subscription_id, quantity = EXCLUDED.quantity, shopify_product_id = EXCLUDED.shopify_product_id, product_title = EXCLUDED.product_title"
        conn.prepare('statement2', "#{my_order_line_fixed_insert}")

        my_order_line_variable_insert = "insert into order_line_items_variable (order_id, name, value) values ($1, $2, $3)"
        conn.prepare('statement3', "#{my_order_line_variable_insert}")

        my_order_shipping_insert = "insert into order_shipping_address (order_id, province, city, first_name, last_name, zip, country, address1, address2, company, phone) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) ON CONFLICT (order_id) DO UPDATE SET province = EXCLUDED.province, city = EXCLUDED.city, first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name, zip = EXCLUDED.zip, country = EXCLUDED.country, address1 = EXCLUDED.address1, address2 = EXCLUDED.address2, company = EXCLUDED.company, phone = EXCLUDED.phone"
        conn.prepare('statement4', "#{my_order_shipping_insert}")

        my_order_billing_insert = "insert into order_billing_address (order_id, province, city, first_name, last_name, zip, country, address1, address2, company, phone) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) ON CONFLICT (order_id) DO UPDATE SET province = EXCLUDED.province, city = EXCLUDED.city, first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name, zip = EXCLUDED.zip, country = EXCLUDED.country, address1 = EXCLUDED.address1, address2 = EXCLUDED.address2, company = EXCLUDED.company, phone = EXCLUDED.phone"
        conn.prepare('statement5', "#{my_order_billing_insert}")



        start = Time.now
        page_size = 250
        num_pages = (my_count/page_size.to_f).ceil
        1.upto(num_pages) do |page|
            orders = HTTParty.get("https://api.rechargeapps.com/orders?updated_at_min=\'#{twenty_five_minutes_ago_str}\'&limit=250&page=#{page}", :headers => my_header)
            my_orders = orders.parsed_response['orders']
            recharge_limit = orders.response["x-recharge-limit"]
            puts "Here recharge_limit = #{recharge_limit}"
            logger.info "Here recharge_limit = #{recharge_limit}"
            my_orders.each do |order|
                #logger.debug order.inspect
                puts order.inspect
                order_id = order['id']
                transaction_id = order['id']
                charge_status = order['charge_status']
                payment_processor = order['payment_processor']
                address_is_active = order['address_is_active'].to_i
                status = order['status']
                type = order['type']
                charge_id = order['charge_id']
                address_id = order['address_id']
                shopify_id = order['shopify_id']
                shopify_order_id = order['shopify_order_id']
                shopify_order_number = order['shopify_order_number']
                shopify_cart_token = order['shopify_cart_token']
                shipping_date = order['shipping_date']
                scheduled_at = order['scheduled_at']
                shipped_date = order['shipped_date']
                processed_at = order['processed_at']
                customer_id = order['customer_id']
                first_name = order['first_name']
                last_name = order['last_name']
                is_prepaid = order['is_prepaid'].to_i
                created_at = order['created_at']
                updated_at = order['updated_at']
                email = order['email']
                line_items = order['line_items'].to_json
                raw_line_items = order['line_items'][0]
    
                shopify_variant_id = raw_line_items['shopify_variant_id']
                title = raw_line_items['title']
                variant_title = raw_line_items['variant_title']
                subscription_id = raw_line_items['subscription_id']
                quantity = raw_line_items['quantity'].to_i
                shopify_product_id = raw_line_items['shopify_product_id']
                product_title = raw_line_items['product_title']
                conn.exec_prepared('statement2', [ order_id, shopify_variant_id, title, variant_title,  subscription_id, quantity, shopify_product_id, product_title ])

                my_delete = "delete from order_line_items_variable where order_id = \'#{order_id}\'"
                conn.exec(my_delete)
                variable_line_items = raw_line_items['properties']
                variable_line_items.each do |myprop|
                    myname = myprop['name']
                    myvalue = myprop['value']
                    conn.exec_prepared('statement3', [ order_id, myname, myvalue ])
                end



                total_price = order['total_price']
                shipping_address = order['shipping_address'].to_json
                billing_address = order['billing_address'].to_json

                #insert shipping_address sub table
                raw_shipping_address = order['shipping_address']
                ord_ship_province = raw_shipping_address['province']
                ord_ship_city = raw_shipping_address['city']
                ord_ship_first_name = raw_shipping_address['first_name']
                ord_ship_last_name = raw_shipping_address['last_name']
                ord_ship_zip = raw_shipping_address['zip']
                ord_ship_country = raw_shipping_address['country']
                ord_ship_address1 = raw_shipping_address['address1']
                ord_ship_address2 = raw_shipping_address['address2']
                ord_ship_company = raw_shipping_address['company']
                ord_ship_phone = raw_shipping_address['phone']
                conn.exec_prepared('statement4', [ order_id, ord_ship_province, ord_ship_city, ord_ship_first_name, ord_ship_last_name, ord_ship_zip, ord_ship_country, ord_ship_address1, ord_ship_address2, ord_ship_company, ord_ship_phone ])

                #insert billing_address sub table
                raw_billing_address = order['billing_address']
                ord_bill_province = raw_billing_address['province']
                ord_bill_city = raw_billing_address['city']
                ord_bill_first_name = raw_billing_address['first_name']
                ord_bill_last_name = raw_billing_address['last_name']
                ord_bill_zip = raw_billing_address['zip']
                ord_bill_country = raw_billing_address['country']
                ord_bill_address1 = raw_billing_address['address1']
                ord_bill_address2 = raw_billing_address['address2']
                ord_bill_company = raw_billing_address['company']
                ord_bill_phone = raw_billing_address['phone']
                conn.exec_prepared('statement5', [ order_id, ord_bill_province, ord_bill_city, ord_bill_first_name, ord_bill_last_name, ord_bill_zip, ord_bill_country, ord_bill_address1, ord_bill_address2, ord_bill_company, ord_bill_phone ])

                #insert into orders
                conn.exec_prepared('statement1', [order_id, transaction_id, charge_status, payment_processor, address_is_active, status, type, charge_id, address_id, shopify_id, shopify_order_id, shopify_order_number, shopify_cart_token, shipping_date, scheduled_at, shipped_date, processed_at, customer_id, first_name, last_name, is_prepaid, created_at, updated_at, email, line_items, total_price, shipping_address, billing_address])


          end
          #logger.info "Done with page #{page}"
          logger.info "Done with page #{page}"
          current = Time.now
          duration = (current - start).ceil
          logger.info "Been running #{duration} seconds"
          determine_limits(recharge_limit, 0.65)

        end
        #logger.info "All done with FULL order download"
        puts "All done with PARTIAL order download"
        conn.close


    end



end
