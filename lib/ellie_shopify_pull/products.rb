#pull_shopify_products.rb

require "./lib/ellie_shopify_pull/base.rb"

module EllieShopifyPull
  class Products < Base

    def fetch
      puts "Starting all shopify resources download from #{shop.name}"
      product_count = ShopifyAPI::Product.count()

      puts "We have #{product_count} products for #{shop.name}"
      cursor_num_products = 0
      num_variants = 0

      Product.delete_all
      ActiveRecord::Base.connection.reset_pk_sequence!('products')
      EllieVariant.delete_all
      ActiveRecord::Base.connection.reset_pk_sequence!('ellie_variants')

      products = []
      variants = []
      shopify_products = ShopifyAPI::Product.find(:all)

      shopify_products.each do |shopify_product|
        products << build_product_attributes(shopify_product)
        shopify_variants = shopify_product.variants

        shopify_variants.each do |shopify_variant|
          variants << build_variant_attributes(shopify_variant)
          num_variants += 1
        end

        wait_for_shopify_credits
        cursor_num_products += 1
      end

      while shopify_products.next_page?
        shopify_products = shopify_products.fetch_next_page

        shopify_products.each do |shopify_product|
          products << build_product_attributes(shopify_product)

          shopify_variants = shopify_product.variants
          shopify_variants.each do |shopify_variant|
            variants << build_variant_attributes(shopify_variant)
            num_variants += 1
          end

          cursor_num_products += 1
        end
        wait_for_shopify_credits
      end

      store_products(products.flatten)
      store_variants(variants.flatten)
    end

    private

    def store_products(products)
      Product.import(products, batch_size: 50, all_or_none: true)
      puts "Total products stored: #{Product.count}"
    end

    def store_variants(variants)
      EllieVariant.import(variants, batch_size: 50, all_or_none: true)
      puts "Total variants stored: #{EllieVariant.count}"
    end

    def build_product_attributes(product)
      {
        shopify_id: product.attributes['id'],
        title: product.attributes['title'],
        product_type: product.attributes['product_type'],
        created_at: product.attributes['created_at'],
        updated_at: product.attributes['updated_at'],
        handle: product.attributes['handle'],
        template_suffix: product.attributes['template_suffix'],
        body_html: product.attributes['body_html'],
        tags: product.attributes['tags'],
        published_scope: product.attributes['published_scope'],
        vendor: product.attributes['vendor'],
        options: product.attributes['options'][0].attributes,
        images: product.attributes['images'].map{|image| image.attributes },
        image: product.attributes['image']
      }
    end

    def build_variant_attributes(variant)
      {
        variant_id: variant.attributes['id'],
        product_id: variant.prefix_options[:product_id],
        title: variant.attributes['title'],
        price: variant.attributes['price'],
        sku: variant.attributes['sku'],
        position: variant.attributes['position'],
        inventory_policy: variant.attributes['inventory_policy'],
        compare_at_price: variant.attributes['compare_at_price'],
        fulfillment_service: variant.attributes['fulfillment_service'],
        inventory_management: variant.attributes['inventory_management'],
        option1: variant.attributes['option1'],
        option2: variant.attributes['option2'],
        option3: variant.attributes['option3'],
        created_at: variant.attributes['created_at'],
        updated_at: variant.attributes['updated_at'],
        taxable: variant.attributes['taxable'],
        barcode: variant.attributes['barcode'],
        weight_unit: variant.attributes['weight_unit'],
        weight: variant.attributes['weight'],
        inventory_quantity: variant.attributes['inventory_quantity'],
        image_id: variant.attributes['image_id'],
        grams: variant.attributes['grams'],
        inventory_item_id: variant.attributes['inventory_item_id'],
        tax_code: variant.attributes['tax_code'],
        old_inventory_quantity: variant.attributes['old_inventory_quantity'],
        requires_shipping: variant.attributes['requires_shipping']
      }
    end
  end
end
