#update_ellie_staging.rb

require 'dotenv'
Dotenv.load
require 'httparty'
require 'resque'
require 'sinatra'
require 'active_record'
require "sinatra/activerecord"
#require_relative '../models/staging_subscriptions_update.rb'
Dir[File.join(__dir__, "../models/**/*.rb")].each do |file|
    require_relative file
  end
  


require_relative 'ellie_staging_resque'

module FixStagingSubs
    class RechargeStaging

        def initialize
            recharge_regular = ENV['RECHARGE_ACCESS_TOKEN']
            @sleep_recharge = ENV['RECHARGE_SLEEP_TIME']
            @my_header = {
              "X-Recharge-Access-Token" => recharge_regular
            }
            @my_change_charge_header = {
                "X-Recharge-Access-Token" => recharge_regular,
                "Accept" => "application/json",
                "Content-Type" =>"application/json"
              }
            
            #@uri = URI.parse(ENV['DATABASE_URL'])

        end


        def create_subs_for_updating
            StagingSubscriptionUpdate.delete_all
            ActiveRecord::Base.connection.reset_pk_sequence!('staging_subscriptions_update')
            my_sql = "insert into staging_subscriptions_update (subscription_id, product_title, price, shopify_product_id, shopify_variant_id, sku, raw_line_item_properties) select subscription_id, product_title, price, shopify_product_id, shopify_variant_id, sku, raw_line_item_properties from subscriptions where status = 'ACTIVE' "
            ActiveRecord::Base.connection.execute(my_sql)
            puts "All done setting up staging_subscriptions_update table!"

        end

        def setup_staging_next_month_info
            StagingNextMonth.delete_all
            ActiveRecord::Base.connection.reset_pk_sequence!('staging_next_month')
            CSV.foreach('elliestaging_aug_subs_new.csv', :encoding => 'ISO-8859-1', :headers => true) do |row|
                 puts row.inspect
                 my_next_mo = StagingNextMonth.create(sub_type: row['sub_type'], product_title: row['product_title'], shopify_product_id: row['shopify_product_id'], shopify_variant_id: row['shopify_variant_id'], sku: row['sku'], product_collection: row['product_collection'])
                 puts my_next_mo.inspect
                
              end

        end

        def update_ellie_staging_subs_next_month
            params = {"action" => "update_ellie_staging_next_month", "recharge_change_header" => @my_change_charge_header}
            puts "in the main body"
            Resque.enqueue(UpdateEllieStagingSubs, params)

        
        end

        class UpdateEllieStagingSubs
            extend EllieStagingSubsHelper
            @queue = "update_ellie_staging_subs"
            def self.perform(params)
              #puts "not yet sending to file"
              fix_ellie_staging_subs(params)
            end
          end
      

    end
end