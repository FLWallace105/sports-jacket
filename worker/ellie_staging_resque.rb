#ellie_staging_resque.rb
require 'dotenv'
require 'active_support/core_ext'
require 'sinatra/activerecord'
require 'httparty'
#require_relative '../models/staging_subscriptions_update.rb'
Dir['../models/**/*.rb'].each do |file|
    require_relative file
  end
require 'pry'

Dotenv.load

module EllieStagingSubsHelper

    def setup_subchange(subscription_id, recharge_change_header)
        stuff_to_return = Hash.new

        mysub = StagingSubscriptionUpdate.find_by_subscription_id(subscription_id)
        puts mysub.inspect
        sub_updated = false
        if mysub.product_title == "3 MONTHS"
            puts "Got a THREE MONTHS subscriber"
            puts "-----------------------------"
            #Don't touch the subscription!
            sub_updated = true
        end

        if  mysub.raw_line_item_properties == []
            
            puts "Empty raw line item properties"
            puts "Must fill them out"
            puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&"  
            three_item_properties =  [{"name"=>"charge_interval_frequency", "value"=>"1"}, {"name"=>"charge_interval_unit_type", "value"=>"Months"}, {"name"=>"leggings", "value"=>"S"}, {"name"=>"main-product", "value"=>"true"}, {"name"=>"product_collection", "value"=>"Vinyasa Vibes - 3 Items"}, {"name"=>"shipping_interval_frequency", "value"=>"1"}, {"name"=>"shipping_interval_unit_type", "value"=>"Months"}, {"name"=>"sports-bra", "value"=>"S"}, {"name"=>"tops", "value"=>"S"}, {"name"=>"sports-jacket", "value"=>"S"}] 
            five_item_properties =  [{"name"=>"charge_interval_frequency", "value"=>"1"}, {"name"=>"charge_interval_unit_type", "value"=>"Months"}, {"name"=>"leggings", "value"=>"S"}, {"name"=>"main-product", "value"=>"true"}, {"name"=>"product_collection", "value"=>"Vinyasa Vibes - 5 Items"}, {"name"=>"shipping_interval_frequency", "value"=>"1"}, {"name"=>"shipping_interval_unit_type", "value"=>"Months"}, {"name"=>"sports-bra", "value"=>"S"}, {"name"=>"tops", "value"=>"S"}, {"name"=>"sports-jacket", "value"=>"S"}]

            if mysub.price > 39.99
                my_update_data = StagingNextMonth.find_by_sub_type(5)
                stuff_to_return = { "sku" => my_update_data.sku, "product_title" => my_update_data.product_title, "shopify_product_id" => my_update_data.shopify_product_id, "shopify_variant_id" => my_update_data.shopify_variant_id, "properties" => five_item_properties }
            else
                my_update_data = StagingNextMonth.find_by_sub_type(3)
                stuff_to_return = { "sku" => my_update_data.sku, "product_title" => my_update_data.product_title, "shopify_product_id" => my_update_data.shopify_product_id, "shopify_variant_id" => my_update_data.shopify_variant_id, "properties" => three_item_properties }
            end

            
            body = stuff_to_return.to_json

            my_update_sub = HTTParty.put("https://api.rechargeapps.com/subscriptions/#{mysub.subscription_id}", :headers => recharge_change_header, :body => body, :timeout => 80)
            puts my_update_sub.inspect
            mysub.is_updated = true
            mysub.updated_at = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
            mysub.save
            sleep 4

            sub_updated = true
        end

        if !sub_updated
            puts "Fixing subscription"
            #here we handle ordinary subscriptions
            #must also add sports-jacket size based on tops size.
            #Go by price
            if mysub.price > 39.99
                my_update_data = StagingNextMonth.find_by_sub_type(5)
                my_product_collection = my_update_data.product_collection
                found_collection = false
                my_line_items = mysub.raw_line_item_properties
                my_line_items.map do |mystuff|
                    # puts "#{key}, #{value}"
                    if mystuff['name'] == 'product_collection'
                      mystuff['value'] = my_product_collection
                      found_collection = true
                    end
                  end
                puts "my_line_items = #{my_line_items.inspect}"
                if found_collection == false
                    # only if I did not find the product_collection property in the line items do I need to add it
                    puts "We are adding the product collection to the line item properties"
                    my_line_items << { "name" => "product_collection", "value" => my_product_collection }
                end
                #Now figure out if there is a sports-jacket in the properties
                found_sports_jacket = false
                sports_jacket_size = ""
                my_line_items.map do |mystuff|
                    # puts "#{key}, #{value}"
                    if mystuff['name'] == 'sports-jacket'
                      #mystuff['value'] = my_product_collection
                      found_sports_jacket = true
                    end
                    if mystuff['name'] == "tops"
                        sports_jacket_size = mystuff['value']   
                    end
                  end

                if found_sports_jacket == false
                    my_line_items << { "name" => "sports-jacket", "value" => sports_jacket_size }

                end


                stuff_to_return = { "sku" => my_update_data.sku, "product_title" => my_update_data.product_title, "shopify_product_id" => my_update_data.shopify_product_id, "shopify_variant_id" => my_update_data.shopify_variant_id, "properties" => my_line_items }

                body = stuff_to_return.to_json

                my_update_sub = HTTParty.put("https://api.rechargeapps.com/subscriptions/#{mysub.subscription_id}", :headers => recharge_change_header, :body => body, :timeout => 80)
                puts my_update_sub.inspect
                mysub.is_updated = true
                mysub.updated_at = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
                mysub.save
                sleep 4
            else
                my_update_data = StagingNextMonth.find_by_sub_type(3)
                my_product_collection = my_update_data.product_collection
                found_collection = false
                my_line_items = mysub.raw_line_item_properties
                my_line_items.map do |mystuff|
                    # puts "#{key}, #{value}"
                    if mystuff['name'] == 'product_collection'
                      mystuff['value'] = my_product_collection
                      found_collection = true
                    end
                  end
                puts "my_line_items = #{my_line_items.inspect}"
                if found_collection == false
                    # only if I did not find the product_collection property in the line items do I need to add it
                    puts "We are adding the product collection to the line item properties"
                    my_line_items << { "name" => "product_collection", "value" => my_product_collection }
                end

                #Now figure out if there is a sports-jacket in the properties
                found_sports_jacket = false
                sports_jacket_size = ""
                my_line_items.map do |mystuff|
                    # puts "#{key}, #{value}"
                    if mystuff['name'] == 'sports-jacket'
                      #mystuff['value'] = my_product_collection
                      found_sports_jacket = true
                    end
                    if mystuff['name'] == "tops"
                        sports_jacket_size = mystuff['value']   
                    end
                  end

                if found_sports_jacket == false
                    my_line_items << { "name" => "sports-jacket", "value" => sports_jacket_size }

                end


                stuff_to_return = { "sku" => my_update_data.sku, "product_title" => my_update_data.product_title, "shopify_product_id" => my_update_data.shopify_product_id, "shopify_variant_id" => my_update_data.shopify_variant_id, "properties" => my_line_items }

                body = stuff_to_return.to_json

                my_update_sub = HTTParty.put("https://api.rechargeapps.com/subscriptions/#{mysub.subscription_id}", :headers => recharge_change_header, :body => body, :timeout => 80)
                puts my_update_sub.inspect
                mysub.is_updated = true
                mysub.updated_at = DateTime.now.strftime("%Y-%m-%d %H:%M:%S")
                mysub.save
                sleep 4

            end

        end


    end



  
    def fix_ellie_staging_subs(params)
        puts params.inspect
        puts "Got here"
        recharge_change_header = params['recharge_change_header']
        my_subs = StagingSubscriptionUpdate.where("is_updated = ?", false)
        my_subs.each do |sub|
            puts sub.inspect
            setup_subchange(sub.subscription_id, recharge_change_header)
            
            
            

            

        end
    end


end
