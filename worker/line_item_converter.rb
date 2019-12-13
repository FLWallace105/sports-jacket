module LineItemConverter
  VARIABLE_PROPS = [
    "charge_interval_frequency",
    "charge_interval_unit_type",
    "leggings",
    "tops",
    "product_collection",
    "shipping_interval_frequency",
    "shipping_interval_unit_type",
    "referrer",
    "sports-bra",
    "main-product",
    "product_id",
    "sports-jacket",
    "unique_identifier",
    "gloves"
  ]
  def self.dejsonify(my_json)
    # parse my_json into array of hashes
    hash_array = JSON.parse(my_json)
    res_array = []
    # if first hash has 'name' key, its a Subscription
    if hash_array[0].has_key?('name')
      prop_hash = hash_array.map {|hsh| [hsh['name'], hsh['value']]}.to_h
      res_array << prop_hash
      return res_array
    # its an Order
    else
      hash_array.each do |hsh|
        prop_hash = hsh['properties'].map {|hsh| [hsh['name'], hsh['value']]}.to_h
        flat_hash = hsh.merge(prop_hash)
        res_array << flat_hash.select do |k, v|
          [k != "properties", k != "images"].all?
        end
      end
      return res_array
    end
  end

  def self.jsonify(my_model, format_type)
    res = []
    if format_type == "subsciption"

    elsif format_type == "order"
      begin
        new_line_item = {
          "quantity" => my_model.quantity,
          "sku" => my_model.sku,
          "variant_title" => my_model.variant_title,
          "product_id" => my_model.shopify_product_id,
          "variant_id" => my_model.shopify_variant_id,
          "subscription_id" => my_model.subscription_id,
          "grams" => my_model.grams,
          "price" => my_model.price
        }
        if my_model.product_title
          new_line_item['product_title'] = my_model.product_title
        end
        new_properties = []
        my_model.attributes.each do |k, v|
          if VARIABLE_PROPS.include?(k)
            new_properties.push({ "name" => k, "value" => v})
          end
        end
        new_line_item['properties'] = new_properties
        res.push(new_line_item)
      rescue StandardError => e
        Resque.logger.warn "ERROR local Order for subscription(#{my_model.subscription_id}) missing property"
        puts "ERROR local Order for subscription(#{my_model.subscription_id}) missing property"
        Resque.logger.warn e
        puts e
      end
      return res.to_json
    else
      raise ArgumentError, 'format_type arg has to be order or subscription'
    end
  end
end
