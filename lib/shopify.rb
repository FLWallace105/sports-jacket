require 'rubygems'
require 'shopify_api'

class Shopify

  def initialize(shop_url)
    puts shop_url.inspect
    ShopifyAPI::Base.site = shop_url.nil? ? default_url : shop_url
  end

  private

  def default_url
  	"https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin"
  end
end
