#new_download_recharge.rb
require_relative 'background_subs'
require_relative 'background_full_subs'
require_relative 'background_full_orders'
require_relative 'background_partial_orders'
require_relative 'background_full_customers'
require_relative 'background_partial_customers'




module DownloadRecharge
    class GetRechargeInfo
        def initialize
            recharge_regular = ENV['RECHARGE_ACCESS_TOKEN']
            @sleep_recharge = ENV['RECHARGE_SLEEP_TIME']
            @my_header = {
              "X-Recharge-Access-Token" => recharge_regular
            }
            
            @uri = URI.parse(ENV['DATABASE_URL'])
            #@conn = PG.connect(@uri.hostname, @uri.port, nil, nil, @uri.path[1..-1], @uri.user, @uri.password)
          end

          def get_recharge_subscriptions_last_hour

            params = {"uri" => @uri, "headers" => @my_header}
            Resque.enqueue(SubsBackground, params)
       
          end

          def get_full_subscriptions
            params = {"uri" => @uri, "headers" => @my_header}
            Resque.enqueue(SubsFullBackground, params)

          end

          def get_full_orders
            params = {"uri" => @uri, "headers" => @my_header}
            Resque.enqueue(OrdersFullBackground, params)


          end

          def get_partial_orders
            params = {"uri" => @uri, "headers" => @my_header}
            Resque.enqueue(OrdersPartialBackground, params)

          end


          def get_full_customers
            params = {"uri" => @uri, "headers" => @my_header}
            Resque.enqueue(CustomersFullBackground, params)
          end

          def get_partial_customers
            params = {"uri" => @uri, "headers" => @my_header}
            Resque.enqueue(CustomersPartialBackground, params)

          end

          class CustomersPartialBackground
            extend PartialBackgroundCustomers
            @queue = "customers_partial_background"
            def self.perform(params)
              get_partial_customers(params)
            end
          end

          class CustomersFullBackground
            extend FullBackgroundCustomers
            @queue = "customers_full_background"
            def self.perform(params)
              get_background_full_customers(params)
            end 


          end

          class OrdersPartialBackground
            extend PartialBackgroundOrders
            @queue = "orders_partial_background"
            def self.perform(params)
              get_background_partial_orders(params)

            end 

          end

          class OrdersFullBackground
            extend FullBackgroundOrders
            @queue = "orders_full_background"
            def self.perform(params)
              get_full_background_orders(params)

            end 
          end

          class SubsBackground
            extend BackgroundSubs
            #include Logging
            @queue = "subs_background_hour"
            def self.perform(params)
              #logger.debug "PullOrder#perform params: #{params.inspect}"
              #get_order_full(params)
              get_subs_last_hour(params)

            end
          end

          class SubsFullBackground
            extend FullBackgroundSubs
            @queue = "subs_background_full"
            def self.perform(params)
              get_all_subs(params)
            end


          end


    end
end