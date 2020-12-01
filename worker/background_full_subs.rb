#background_full_subs.rb

require 'uri'
require_relative '../lib/recharge_limit'
require_relative '../lib/background_helper'

module FullBackgroundSubs
    include ReChargeLimits
    include BackgroundHelper

    def get_all_subs(params)
        Resque.logger = Logger.new("#{Dir.getwd}/logs/get_all_subs.log")
        Resque.logger.info "FullBackgroundSubs#get_all_subs: #{params}"
        puts "params = #{params.inspect}"
        uri = params['uri']
        my_header = params["headers"]
        puts "I am here"

        #Mix of Active Record for slow stuff anyway and raw sql for things that are otherwise slower 
        Subscription.delete_all
        ActiveRecord::Base.connection.reset_pk_sequence!('subscriptions')
        SubLineItem.delete_all
        ActiveRecord::Base.connection.reset_pk_sequence!('sub_line_items')
        SubCollectionSize.delete_all
        ActiveRecord::Base.connection.reset_pk_sequence!('sub_collection_sizes')
        puts "Done set up"
        

        myuri = URI.parse(uri)
        conn =  PG.connect(myuri.hostname, myuri.port, nil, nil, myuri.path[1..-1], myuri.user, myuri.password)
    
        #Postgresql 9.6 upsert code
        my_insert = "insert into subscriptions (subscription_id, address_id, customer_id, created_at, updated_at, next_charge_scheduled_at, cancelled_at, product_title, price, quantity, status, shopify_product_id, shopify_variant_id, sku, order_interval_unit, order_interval_frequency, charge_interval_frequency, order_day_of_month, order_day_of_week, raw_line_item_properties, expire_after_specific_number_charges, is_prepaid) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22) on conflict (subscription_id) do update set address_id = EXCLUDED.address_id, customer_id = EXCLUDED.customer_id, created_at = EXCLUDED.created_at, updated_at = EXCLUDED.updated_at, next_charge_scheduled_at = EXCLUDED.next_charge_scheduled_at, cancelled_at = EXCLUDED.cancelled_at, product_title = EXCLUDED.product_title, price = EXCLUDED.price, quantity = EXCLUDED.quantity, status = EXCLUDED.status, shopify_product_id = EXCLUDED.shopify_product_id, shopify_variant_id = EXCLUDED.shopify_variant_id, sku = EXCLUDED.sku, order_interval_unit = EXCLUDED.order_interval_unit, order_interval_frequency = EXCLUDED.order_interval_frequency, charge_interval_frequency = EXCLUDED.charge_interval_frequency, order_day_of_month = EXCLUDED.order_day_of_month, order_day_of_week = EXCLUDED.order_day_of_week, raw_line_item_properties = EXCLUDED.raw_line_item_properties, expire_after_specific_number_charges = EXCLUDED.expire_after_specific_number_charges, is_prepaid = EXCLUDED.is_prepaid"
        conn.prepare('statement1', "#{my_insert}")
        my_line_item_insert = "insert into sub_line_items (subscription_id, name, value) values ($1, $2, $3)"
        conn.prepare('statement2', "#{my_line_item_insert}")


        subscriptions = HTTParty.get("https://api.rechargeapps.com/subscriptions/count?status=ACTIVE", :timeout => 80, :headers => my_header)
        #my_response = JSON.parse(subscriptions)
        my_response = subscriptions
        my_count = my_response['count'].to_i

        start = Time.now

        page_size = 250
        num_pages = (my_count/page_size.to_f).ceil
        1.upto(num_pages) do |page|

          #uri = URI("https://api.rechargeapps.com/subscriptions?status=ACTIVE&limit=250&page=#{page}")
          #req = Net::HTTP::Get.new(uri)

          #req.open_timeout = 80 # in seconds
          #req.read_timeout = 80 # in seconds

          #req['X-Recharge-Access-Token'] = ENV['RECHARGE_ACCESS_TOKEN']
          #req['X-Recharge-Access-Token'] = ENV['ellie_recharge_api_key']
          #res = Net::HTTP.start(uri.hostname, uri.port,:use_ssl => uri.scheme == 'https', :read_timeout => 800) {|http| http.request(req)}
          #mysubs = JSON.parse(res.body)

          #recharge_limit = res["x-recharge-limit"]


          mysubs = HTTParty.get("https://api.rechargeapps.com/subscriptions?status=ACTIVE&limit=250&page=#{page}", :timeout => 120, :headers => my_header)
          #puts mysubs.inspect
          recharge_limit = mysubs.response["x-recharge-limit"]
          puts "Here recharge_limit = #{recharge_limit}"
          #Resque.logger.info "Here recharge_limit = #{recharge_limit}"
          #my_limit = determine_limits(recharge_limit, 0.65)

          
          local_sub = mysubs['subscriptions']
          local_sub.each do |sub|
                puts "-------------------"
                puts sub['id']
                #puts sub.inspect
                puts "------------------"
                #Resque.logger.info "-------------------"
                #Resque.logger.info sub.inspect
                #Resque.logger.info "------------------"

                subscription_id = sub['id']

                address_id = sub['address_id']
                customer_id = sub['customer_id']
                created_at = sub['created_at']
                updated_at = sub['updated_at']
                next_charge_scheduled_at = sub['next_charge_scheduled_at']
                cancelled_at = sub['cancelled_at']
                product_title = sub['product_title']
                price = sub['price']
                quantity = sub['quantity']
                status = sub['status']
                shopify_product_id = sub['shopify_product_id']
                shopify_variant_id = sub['shopify_variant_id']
                sku = sub['sku']
                order_interval_unit = sub['order_interval_unit']
                order_interval_frequency = sub['order_interval_frequency']
                charge_interval_frequency = sub['charge_interval_frequency']
                order_day_of_month = sub['order_day_of_month']
                order_day_of_week = sub['order_day_of_week']
                raw_properties = sub['properties']
                properties = sub['properties'].to_json
                expire_after = sub['expire_after_specific_number_charges']
                is_prepaid = sub['is_prepaid']



                insert_result = conn.exec_prepared('statement1', [ subscription_id, address_id, customer_id, created_at, updated_at, next_charge_scheduled_at, cancelled_at, product_title, price, quantity, status, shopify_product_id, shopify_variant_id, sku, order_interval_unit, order_interval_frequency, charge_interval_frequency, order_day_of_month, order_day_of_week, properties, expire_after, is_prepaid])
                #puts insert_result.inspect
                #Resque.logger.info insert_result.inspect

                raw_properties.each do |temp|
                    temp_name = temp['name']
                    temp_value = temp['value']
                    #puts "#{temp_name}, #{temp_value}"
                    if !temp_value.nil? && !temp_name.nil?
                      
                      sub_insert = conn.exec_prepared('statement2', [ subscription_id, temp_name, temp_value ])
                      #puts "inserted subscription #{subscription_id}"
                      #puts sub_insert.inspect
                      #Resque.logger.info "inserted subscription #{subscription_id}"
                      #Resque.logger.info sub_insert.inspect
                  
                    end
                end

                my_data = create_properties(raw_properties, charge_interval_frequency)
                product_collection = my_data['product_collection']
                leggings = my_data['leggings']
                tops = my_data['tops']
                sports_bra = my_data['sports_bra']
                sports_jacket = my_data['sports_jacket']
                gloves = my_data['gloves']
                prepaid = my_data['prepaid']
                SubCollectionSize.create(subscription_id: subscription_id,
                                         product_collection: product_collection,
                                         leggings: leggings, tops: tops,
                                         sports_bra: sports_bra,
                                         sports_jacket: sports_jacket,
                                         gloves: gloves, prepaid: prepaid, next_charge_scheduled_at: next_charge_scheduled_at)


          end
          puts "Done with page #{page}"
          Resque.logger.info "Done with page #{page}"
          current = Time.now
          duration = (current - start).ceil
          puts "Been running #{duration} seconds"
          Resque.logger.info "Been running #{duration} seconds"
          puts "Sleeping 10 secs"
          sleep 10
          determine_limits(recharge_limit, 0.65)
        end
        puts "All done inserting new subscriptions"
        Resque.logger.info "All done inserting new subscriptions"
        conn.close

    end


end
