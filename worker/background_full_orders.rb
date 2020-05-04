#background_orders.rb

require_relative '../lib/recharge_limit'

module FullBackgroundOrders
    include ReChargeLimits


        def get_min_max
            my_yesterday = Date.today - 1
            my_yesterday_str = my_yesterday.strftime("%Y-%m-%d")
            my_four_months = Date.today >> 4
            my_four_months = my_four_months.end_of_month
            my_four_months_str = my_four_months.strftime("%Y-%m-%d")
            my_hash = Hash.new
            my_hash = {"min" => my_yesterday_str, "max" => my_four_months_str}
            return my_hash

        end



        def get_full_background_orders(params)
            puts params.inspect
            uri = params['uri']
            my_header = params["headers"]
            min_max = get_min_max
            min = min_max['min']
            max = min_max['max']
            sleep_recharge = 4
            puts min_max.inspect
            orders_count = HTTParty.get("https://api.rechargeapps.com/orders/count?scheduled_at_min=\'#{min}\'&scheduled_at_max=\'#{max}\'", :headers => my_header)
            #my_response = JSON.parse(subscriptions)
            my_response = orders_count
            my_count = my_response['count'].to_i
            puts my_count

            Order.delete_all
            ActiveRecord::Base.connection.reset_pk_sequence!('orders')
            OrderBillingAddress.delete_all
            ActiveRecord::Base.connection.reset_pk_sequence!('order_billing_address')
            OrderShippingAddress.delete_all
            ActiveRecord::Base.connection.reset_pk_sequence!('order_shipping_address')
            OrderLineItemsFixed.delete_all
            ActiveRecord::Base.connection.reset_pk_sequence!('order_line_items_fixed')
            OrderLineItemsVariable.delete_all
            ActiveRecord::Base.connection.reset_pk_sequence!('order_line_items_variable')

            myuri = URI.parse(uri)
            conn =  PG.connect(myuri.hostname, myuri.port, nil, nil, myuri.path[1..-1], myuri.user, myuri.password)

	    my_insert = "insert into orders (order_id, transaction_id, charge_status, payment_processor, address_is_active, status, order_type, charge_id, address_id, shopify_id, shopify_order_id, shopify_order_number, shopify_cart_token, shipping_date, scheduled_at, shipped_date, processed_at, customer_id, first_name, last_name, is_prepaid, created_at, updated_at, email, line_items, total_price, shipping_address, billing_address) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28) ON CONFLICT ON CONSTRAINT ord_id DO UPDATE SET order_id = $1, transaction_id = $2, charge_status = $3, payment_processor = $4, address_is_active = $5, status = $6, order_type = $7, charge_id = $8, address_id = $9, shopify_id = $10, shopify_order_id = $11, shopify_order_number = $12, shopify_cart_token = $13, shipping_date = $14, scheduled_at = $15, shipped_date = $16, processed_at = $17, customer_id = $18, first_name = $19, last_name = $20, is_prepaid = $21, created_at = $22, updated_at = $23, email = $24, line_items = $25, total_price = $26, shipping_address = $27, billing_address = $28 WHERE orders.order_id = $1"
            #my_insert = "insert into orders (order_id, transaction_id, charge_status, payment_processor, address_is_active, status, order_type, charge_id, address_id, shopify_id, shopify_order_id, shopify_order_number, shopify_cart_token, shipping_date, scheduled_at, shipped_date, processed_at, customer_id, first_name, last_name, is_prepaid, created_at, updated_at, email, line_items, total_price, shipping_address, billing_address) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28)"
            conn.prepare('statement1', "#{my_insert}")  
    
            my_order_line_fixed_insert = "insert into order_line_items_fixed (order_id, shopify_variant_id, title, variant_title, subscription_id, quantity, shopify_product_id, product_title) values ($1, $2, $3, $4, $5, $6, $7, $8) ON CONFLICT ON CONSTRAINT ord_fixed DO UPDATE SET order_id = $1, shopify_variant_id = $2, title = $3, variant_title = $4, subscription_id = $5, quantity = $6, shopify_product_id = $7, product_title = $8 WHERE order_line_items_fixed.order_id = $1"
	    # my_order_line_fixed_insert = "insert into order_line_items_fixed (order_id, shopify_variant_id, title, variant_title, subscription_id, quantity, shopify_product_id, product_title) values ($1, $2, $3, $4, $5, $6, $7, $8)"
            conn.prepare('statement2', "#{my_order_line_fixed_insert}") 
    
            my_order_line_variable_insert = "insert into order_line_items_variable (order_id, name, value) values ($1, $2, $3)"
            conn.prepare('statement3', "#{my_order_line_variable_insert}") 
    
	    my_order_shipping_insert = "insert into order_shipping_address (order_id, province, city, first_name, last_name, zip, country, address1, address2, company, phone) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) ON CONFLICT ON CONSTRAINT ord_ship DO UPDATE SET order_id = $1, province = $2, city = $3, first_name = $4, last_name = $5, zip = $6, country = $7, address1 = $8, address2 = $9, company = $10, phone = $11 WHERE order_shipping_address.order_id = $1"
            #my_order_shipping_insert = "insert into order_shipping_address (order_id, province, city, first_name, last_name, zip, country, address1, address2, company, phone) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)"
            conn.prepare('statement4', "#{my_order_shipping_insert}") 
    
	    my_order_billing_insert = "insert into order_billing_address (order_id, province, city, first_name, last_name, zip, country, address1, address2, company, phone) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11) ON CONFLICT ON CONSTRAINT ord_bill DO UPDATE SET order_id = $1, province = $2, city = $3, first_name = $4, last_name = $5, zip = $6, country = $7, address1 = $8, address2 = $9, company = $10, phone = $11 WHERE order_billing_address.order_id = $1"
            #my_order_billing_insert = "insert into order_billing_address (order_id, province, city, first_name, last_name, zip, country, address1, address2, company, phone) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)"
            conn.prepare('statement5', "#{my_order_billing_insert}") 


            start = Time.now
            page_size = 250
            num_pages = (my_count/page_size.to_f).ceil
            1.upto(num_pages) do |page|
                orders = HTTParty.get("https://api.rechargeapps.com/orders?scheduled_at_min=\'#{min}\'&scheduled_at_max=\'#{max}\'&limit=250&page=#{page}", :headers => my_header)
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
                    
                    #fix Floyd Wallace hotfix 4/23/2020 null order line items
                    if raw_line_items != nil 
                    shopify_variant_id = raw_line_items['shopify_variant_id']
                    title = raw_line_items['title']
                    variant_title = raw_line_items['variant_title']
                    subscription_id = raw_line_items['subscription_id']
                    quantity = raw_line_items['quantity'].to_i
                    shopify_product_id = raw_line_items['shopify_product_id']
                    product_title = raw_line_items['product_title']
                    conn.exec_prepared('statement2', [ order_id, shopify_variant_id, title, variant_title,  subscription_id, quantity, shopify_product_id, product_title ])
                    # failing line
    
                    variable_line_items = raw_line_items['properties']
                    variable_line_items.each do |myprop|
                        myname = myprop['name']
                        myvalue = myprop['value']
                        conn.exec_prepared('statement3', [ order_id, myname, myvalue ])
                    end
    
                   end
                   #end hotfix    
    
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
   		# second line failing 
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
        puts "All done with FULL order download"
        conn.close

        

        end



end
