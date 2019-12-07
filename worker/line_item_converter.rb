module LineItemConverter
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

  def jsonify(my_hash)
  end
end
