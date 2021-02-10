require 'rubygems'
#require 'shopify_api'

module BackgroundHelper



  

    

    

    def create_properties(raw_properties, charge_interval_frequency)
        product_collection = raw_properties.select{|x| x['name'] == 'product_collection'}
        if product_collection != []
            product_collection = product_collection.first['value']
        else
            product_collection = nil
        end
        leggings = raw_properties.select{|x| x['name'] == 'leggings'}
        if leggings != []
            leggings = leggings.first['value'].upcase
        else
            leggings = nil
        end
        tops = raw_properties.select{|x| x['name'] == 'tops'}
        if tops != []
            tops = tops.first['value'].upcase
        else
            tops = nil
        end
        sports_bra = raw_properties.select{|x| x['name'] == 'sports-bra'}
        if sports_bra != []
            sports_bra = sports_bra.first['value'].upcase
        else
            sports_bra = nil
        end
        sports_jacket = raw_properties.select{|x| x['name'] == 'sports-jacket'}

        if sports_jacket != []
            sports_jacket = sports_jacket.first['value'].upcase
        else
            sports_jacket = nil
        end
        gloves = raw_properties.select{|x| x['name'] == 'gloves'}
        if gloves != []
            gloves = gloves.first['value'].upcase
        else
            gloves = nil
        end
        #puts charge_interval_frequency.inspect
        prepaid = false
        if charge_interval_frequency.to_i ==  1
            prepaid = false
        else
            prepaid = true
        end
        stuff_to_return = {"product_collection" => product_collection, "leggings" => leggings, "tops" => tops, "sports_bra" => sports_bra, "sports_jacket" => sports_jacket, "gloves" => gloves, "prepaid" => prepaid}
        return stuff_to_return

    end

    def create_order_properties(my_json)
        temp_json = JSON.parse(my_json)
        #puts temp_json
        temp_props = temp_json.first['properties']
        #puts temp_props

        product_collection = temp_props.select{|x| x['name'] == 'product_collection'}
        leggings = temp_props.select{|x| x['name'] == 'leggings'}
        tops = temp_props.select{|x| x['name'] == 'tops'}
        sports_bra = temp_props.select{|x| x['name'] == 'sports-bra'}
        sports_jacket = temp_props.select{|x| x['name'] == 'sports-jacket'}
        gloves = temp_props.select{|x| x['name'] == 'gloves'}

        if product_collection != []
            product_collection = product_collection.first['value']
        else
            product_collection = nil
        end

        if leggings != []
            leggings = leggings.first['value'].upcase
        else
            leggings = nil
        end

        if tops != []
            tops = tops.first['value'].upcase
        else
            tops = nil
        end

        if sports_bra != []
            sports_bra = sports_bra.first['value'].upcase
        else
            sports_bra = nil
        end

        if gloves != []
            gloves = gloves.first['value'].upcase
        else
            gloves = nil
        end

        stuff_to_return = {"product_collection" => product_collection, "leggings" => leggings, "tops" => tops, "sports_bra" => sports_bra, "sports_jacket" => sports_jacket, "gloves" => gloves}
        return stuff_to_return


    end


end