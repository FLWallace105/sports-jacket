require_relative 'new_shopify_pull'


module DownloadShopifyProduct
    class GetInfo
        def initialize
            #
        end

          def get_all_subs
            #puts "hello there"
            Resque.enqueue(BackgroundShopifyPull)
       
          end

          class BackgroundShopifyPull
            extend NewShopifyPull
            @queue = "shopify_products"
            #puts "Howdy!"
            def self.perform
              all_products
            end

          end




    end
end