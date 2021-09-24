#pull_shopify_products.rb
require 'dotenv'
require 'httparty'
require 'shopify_api'
require 'active_record'
require 'sinatra/activerecord'
require 'logger'

Dotenv.load
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }

module EllieShopifyPull
  class Base
    attr :shop
    def initialize(shop_url = nil)
      Shopify.new(shop_url)
      @shop = ShopifyAPI::Shop.current
    end
    
    def self.fetch(shop_url = nil)
      new(shop_url).fetch
    end

    def wait_for_shopify_credits
      return if ShopifyAPI.credit_left > 5

      puts "CREDITS LEFT: #{ShopifyAPI.credit_left}"
      puts "SLEEPING 10"
      sleep 10
    end
  end
end
