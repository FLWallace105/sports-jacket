#background_partial_customers.rb

require_relative '../lib/recharge_limit'
require 'active_support/core_ext/time'

module PartialBackgroundCustomers
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


    def get_partial_customers(params)
        #GET api/customers?updated_at_min='2017-09-22'
        puts "Hi there getting partial customers"
        puts params.inspect
        uri = params['uri']
        my_header = params["headers"]
        twenty_five_minutes_ago_str = twenty_five_min
        
        puts "Here twenty_five_minutes_ago_str = #{twenty_five_minutes_ago_str}"

        customers_count = HTTParty.get("https://api.rechargeapps.com/customers/count?updated_at_min=\'#{twenty_five_minutes_ago_str}\'", :headers => my_header)
            
        my_response = customers_count
        num_customers = my_response['count'].to_i
        puts "We have #{num_customers} customers updated since twenty five minutes ago: #{twenty_five_minutes_ago_str}"
    


        myuri = URI.parse(uri)
        conn =  PG.connect(myuri.hostname, myuri.port, nil, nil, myuri.path[1..-1], myuri.user, myuri.password)

        my_insert = "insert into customers (customer_id, customer_hash, shopify_customer_id, email, created_at, updated_at, first_name, last_name, billing_address1, billing_address2, billing_zip, billing_city, billing_company, billing_province, billing_country, billing_phone, processor_type, status) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18) ON CONFLICT (customer_id) DO UPDATE SET customer_hash = EXCLUDED.customer_hash, shopify_customer_id = EXCLUDED.shopify_customer_id, email = EXCLUDED.email, created_at = EXCLUDED.created_at, updated_at = EXCLUDED.updated_at, first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name, billing_address1 = EXCLUDED.billing_address1, billing_address2 = EXCLUDED.billing_address2, billing_zip = EXCLUDED.billing_zip, billing_city = EXCLUDED.billing_city, billing_company = EXCLUDED.billing_company, billing_province = EXCLUDED.billing_province, billing_country = EXCLUDED.billing_country, billing_phone = EXCLUDED.billing_phone, processor_type = EXCLUDED.processor_type, status = EXCLUDED.status"
        conn.prepare('statement1', "#{my_insert}") 

        start = Time.now    
        page_size = 250
        num_pages = (num_customers/page_size.to_f).ceil
        1.upto(num_pages) do |page|
            customers = HTTParty.get("https://api.rechargeapps.com/customers?updated_at_min=\'#{twenty_five_minutes_ago_str}\'&limit=250&page=#{page}", :headers => my_header)
          my_customers = customers.parsed_response['customers']
          recharge_limit = customers.response["x-recharge-limit"]
          my_customers.each do |mycust|
            #logger.debug 
            puts mycust.inspect
            customer_id = mycust['id']
            hash = mycust['hash']
            shopify_customer_id = mycust['shopify_customer_id']
            email = mycust['email']
            created_at = mycust['created_at']
            updated_at = mycust['updated_at']
            first_name = mycust['first_name']
            last_name = mycust['last_name']
            billing_address1 = mycust['billing_address1']
            billing_address2 = mycust['billing_address2']
            billing_zip = mycust['billing_zip']
            billing_city = mycust['billing_city']
            billing_company = mycust['billing_company']
            billing_province = mycust['billing_province']
            billing_country = mycust['billing_country']
            billing_phone = mycust['billing_phone']
            processor_type = mycust['processor_type']
            status = mycust['status']
            conn.exec_prepared('statement1', [customer_id, hash, shopify_customer_id, email, created_at, updated_at, first_name, last_name, billing_address1, billing_address2, billing_zip, billing_city, billing_company, billing_province, billing_country, billing_phone, processor_type, status])
          end
          puts "Done with page #{page}"
          current = Time.now
          duration = (current - start).ceil
          puts "Running #{duration} seconds"
          determine_limits(recharge_limit, 0.65)

        end
        #do pages

        conn.close



    end


end   