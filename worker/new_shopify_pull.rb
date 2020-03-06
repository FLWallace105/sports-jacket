#new_shopify_pull.rb
require_relative '../config/environment'
#require_relative '../models/product'
module NewShopifyPull
    

    def all_products
        #puts "I am here"
        products = ShopifyAPI::Product.find(:all)
        #First page
        products.each do |myprod|
        #new product pull
   
            published_at = myprod.attributes['published_at']
            shopify_id = myprod.attributes['id']
            myprodtitle = myprod.attributes['title']
            myprod_type = myprod.attributes['product_type']
            mycreated_at = myprod.attributes['created_at']
            myupdated_at = myprod.attributes['updated_at']
            myhandle = myprod.attributes['handle']
            mytemplate_suffix = myprod.attributes['template_suffix']
            mybody_html = myprod.attributes['body_html']
            mytags = myprod.attributes['tags']
            mypublished_scope = myprod.attributes['published_scope']
            myvendor = myprod.attributes['vendor']
            myoptions = myprod.attributes['options'][0].attributes
            myimages_array = Array.new
            myprod.attributes['images'].each do |mystuff|
            #puts mystuff.inspect
                myimages_array << mystuff.attributes
            end

            puts "shopify_id = #{shopify_id}"
            local_product = Product.find_or_initialize_by(shopify_id: shopify_id)
            local_product.title = myprodtitle
            local_product.product_type = myprod_type
            local_product.created_at = mycreated_at
            local_product.updated_at = myupdated_at
            local_product.handle = myhandle
            local_product.template_suffix = mytemplate_suffix
            local_product.body_html = mybody_html
            local_product.tags = mytags
            local_product.published_at = published_at
            local_product.published_scope = mypublished_scope
            local_product.vendor = myvendor
            local_product.options = myoptions
            local_product.image = myimages_array
            local_product.save!(validate: false)
        end
    #Next pages
    while products.next_page?
      products = products.fetch_next_page
      products.each do |myprod|
        
        published_at = myprod.attributes['published_at']
        shopify_id = myprod.attributes['id']
        myprodtitle = myprod.attributes['title']
        myprod_type = myprod.attributes['product_type']
        mycreated_at = myprod.attributes['created_at']
        myupdated_at = myprod.attributes['updated_at']
        myhandle = myprod.attributes['handle']
        mytemplate_suffix = myprod.attributes['template_suffix']
        mybody_html = myprod.attributes['body_html']
        mytags = myprod.attributes['tags']
        mypublished_scope = myprod.attributes['published_scope']
        myvendor = myprod.attributes['vendor']
        myoptions = myprod.attributes['options'][0].attributes
        myimages_array = Array.new
        myprod.attributes['images'].each do |mystuff|
          #puts mystuff.inspect
          myimages_array << mystuff.attributes
        end
        puts "shopify_id = #{shopify_id}"
        local_product = Product.find_or_initialize_by(shopify_id: shopify_id)
        local_product.title = myprodtitle
        local_product.product_type = myprod_type
        local_product.created_at = mycreated_at
        local_product.updated_at = myupdated_at
        local_product.handle = myhandle
        local_product.template_suffix = mytemplate_suffix
        local_product.body_html = mybody_html
        local_product.tags = mytags
        local_product.published_at = published_at
        local_product.published_scope = mypublished_scope
        local_product.vendor = myvendor
        local_product.options = myoptions
        local_product.image = myimages_array
        local_product.save!(validate: false)
      

      end
    end

    end



end