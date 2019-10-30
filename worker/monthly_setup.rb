require_relative '../lib/logging'
require 'active_support/core_ext'
#
#
# CHANGE month TO THIS MONTH OR NEXT MONTH !!!!!
#
#
class MonthlySetup
  include Logging
  def initialize
    month = Time.now.localtime.to_date >> 1
    @sleep_shopify = ENV['SHOPIFY_SLEEP_TIME']
    @shopify_base_site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_SHARED_SECRET']}"\
    "@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin"

    @uri = URI.parse(ENV['DATABASE_URL'])
    @conn = PG.connect(
      @uri.hostname, @uri.port, nil, nil, @uri.path[1..-1], @uri.user, @uri.password
    )
    @next_month_end = Time.local("#{month.strftime('%Y')}", "#{month.strftime('%m')}").end_of_month
    @collection_ids = ProductTag.where("active_end = ?", @next_month_end).pluck(:product_id)
  end
  # configures switchable_products table --step 1
  def switchable_config
    current_array = Product.find_by_sql(
      "SELECT * from products where title NOT LIKE '%Auto renew%' AND"\
      " CAST (shopify_id AS bigint) IN (#{@collection_ids.join(', ')});"
    )
    my_insert =
      "insert into switchable_products (product_title, product_id, threepk) values ($1, $2, $3)"
    @conn.prepare('statement1', "#{my_insert}")
    current_array.each do |x|
      next unless !SwitchableProduct.exists?(:product_id => x.id)
      product_title = x.title
      product_id = x.id
      threepk = x.title.include?('3 Item')? true : false
      @conn.exec_prepared('statement1', [product_title, product_id, threepk])
    end
    logger.info "switchable_config done"
    @conn.close
  end
  # configures alternate_products table --step 2
  def alternate_config
    current_array = Product.find_by_sql(
      "SELECT * from products where title NOT LIKE '%Auto renew%' AND CAST (shopify_id AS bigint) IN (#{@collection_ids.join(', ')});"
    )
    my_insert = "insert into alternate_products"\
    " (product_title, product_id, variant_id, sku, product_collection) values ($1, $2, $3, $4, $5)"
    @conn.prepare('statement2', "#{my_insert}")

    current_array.each do |x|
      next unless !AlternateProduct.exists?(:product_id => x.id)
      product_title = x.title
      product_id = x.id
      variant_id = EllieVariant.find_by(product_id: x.id).variant_id
      sku = EllieVariant.find_by(product_id: x.id).sku
      product_collection = x.title
      @conn.exec_prepared(
        'statement2', [product_title, product_id, variant_id, sku, product_collection]
      )
    end
    logger.info "alternate_config done"
    @conn.close
  end
  def matching_config
    # array of current months product collections
    # not including auto renews
    current_array = Product.find_by_sql(
      "SELECT * from products
      WHERE title NOT LIKE '%Auto renew%'
      AND CAST (shopify_id AS bigint) IN (#{@collection_ids.join(', ')})
      ORDER BY (title);"
    )
    my_insert = "insert into matching_products ("\
    "new_product_title, incoming_product_id, threepk, outgoing_product_id) values ($1, $2, $3, $4)"
    @conn.prepare('statement3', "#{my_insert}")

    current_array.each_with_index do |prod, idx|
      next unless !MatchingProduct.exists?(:new_product_title => prod.title)
      if prod.title.include?('3')
        incoming_product_id = current_array[idx + 1].shopify_id
        threepk = true
      elsif prod.title.include?('5')
        incoming_product_id = prod.shopify_id
        threepk = false
      end
      new_product_title = prod.title
      product_id = incoming_product_id
      # if threepk true, assign 3 item prod id to outgoing_product_id
      outgoing_product_id = (threepk)? prod.shopify_id : incoming_product_id
      @conn.exec_prepared(
        'statement3', [new_product_title, incoming_product_id, threepk, outgoing_product_id]
      )
    end
      logger.info "matching_config done"
      @conn.close
  end
end
