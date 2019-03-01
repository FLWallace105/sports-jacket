require_relative '../lib/logging'

class MonthlySetup
  include Logging
  def initialize
    @sleep_shopify = ENV['SHOPIFY_SLEEP_TIME']
    @shopify_base_site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_SHARED_SECRET']}"\
    "@#{ENV['SHOPIFY_SHOP_NAME']}.myshopify.com/admin"

    @uri = URI.parse(ENV['DATABASE_URL'])
    @conn = PG.connect(
      @uri.hostname, @uri.port, nil, nil, @uri.path[1..-1], @uri.user, @uri.password
    )
  end
  # configures switchable_products table --step 1
  def switchable_config
    current_array = Product.find_by_sql(
      "SELECT * from products where title NOT LIKE '%Auto renew%' AND"\
      " CAST (shopify_id AS bigint) IN (#{MARCH_COLLECTION_IDS.join(', ')});"
    )
    my_insert =
      "insert into switchable_products (product_title, product_id, threepk) values ($1, $2, $3)"
    @conn.prepare('statement1', "#{my_insert}")
    current_array.each do |x|
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
      "SELECT * from products where title NOT LIKE"\
      " '%Auto renew%' AND CAST (shopify_id AS bigint) IN (#{MARCH_COLLECTION_IDS.join(', ')});"
    )
    my_insert = "insert into alternate_products"\
    " (product_title, product_id, variant_id, sku, product_collection) values ($1, $2, $3, $4, $5)"
    @conn.prepare('statement1', "#{my_insert}")

    current_array.each do |x|
      product_title = x.title
      product_id = x.id
      variant_id = EllieVariant.find_by(product_id: x.id).variant_id
      sku = EllieVariant.find_by(product_id: x.id).sku
      product_collection = x.title
      @conn.exec_prepared(
        'statement1', [product_title, product_id, variant_id, sku, product_collection]
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
      AND CAST (shopify_id AS bigint) IN (#{MARCH_COLLECTION_IDS.join(', ')})
      ORDER BY (title);"
    )
    my_insert = "insert into matching_products ("\
    "new_product_title, incoming_product_id, threepk, outgoing_product_id) values ($1, $2, $3, $4)"
    @conn.prepare('statement1', "#{my_insert}")

    current_array.each_with_index do |prod, idx|
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
        'statement1', [new_product_title, incoming_product_id, threepk, outgoing_product_id]
      )
    end
      logger.info "matching_config done"
      @conn.close
  end
end

MARCH_COLLECTION_IDS = [
  '2294123954234',
  '2294127558714',
  '2311603650618',
  '2311674069050',
  '2209786298426',
  '2209789771834',
  '2243360030778',
  '2243359604794',
  '2294128738362',
  '2294130999354',
  '2311684718650',
  '2311711555642',
  '2294131458106',
  '2294132539450',
  '2311729905722',
  '2311740817466',
  '2294132932666',
  '2294135029818',
  '2311757692986',
  '2311847280698',
  '2076342452282',
  '2076357886010',
  '2089364193338',
  '2089098313786',
]
