require_relative '../config/environment'
my_inventory = {
  "sports-jacket" => {
    "XS"=> 110,
    "S"=> 1026,
    "M"=> 1058,
    "L"=> 668,
    "XL"=> 103,
  },
  "sports-bra" => {
    "XS"=> 143,
    "S"=> 598,
    "M"=> 995,
    "L"=> 442,
    "XL"=> 222,
  },
  "leggings" => {
    "XS"=> 101,
    "S"=> 781,
    "M"=> 1081,
    "L"=> 566,
    "XL"=> 118,
  }
}

my_subs = Subscription.find_by_sql("select * from subscriptions where product_title ilike '%Fierce%' and status='ACTIVE'
and next_charge_scheduled_at >= '2019-01-08'and next_charge_scheduled_at < '2019-02-01' order by next_charge_scheduled_at ASC;")
MY_LIST = { "sports-jacket" =>[],
  "sports-bra" => [],
  "leggings" => []
 }

my_subs.each do |sub|
  sub.line_items.each do |line_item|
    begin
      case line_item['name']
      when 'sports-bra'
        my_size = line_item['value']
        my_inventory['sports-bra'][my_size] -= 1
        if my_inventory['sports-bra'][my_size] < 0
            MY_LIST['sports-bra'] << { "id" => sub.customer_id,
                                        "size" => my_size,
                                        "date" => sub['next_charge_scheduled_at'],
                                        "sub_id" => sub['subscription_id'],
                                      }
        end
      when 'tops'
        my_size = line_item['value']
        my_inventory['sports-jacket'][my_size] -= 1
        if my_inventory['sports-jacket'][my_size] < 0
            MY_LIST['sports-jacket'] << { "id" => sub.customer_id,
                                  "size" => my_size,
                                  "date" => sub['next_charge_scheduled_at'],
                                  "sub_id" => sub['subscription_id'],
                                }
        end
      when 'leggings'
        my_size = line_item['value']
        my_inventory['leggings'][my_size] -= 1
        if my_inventory['leggings'][my_size] < 0
            MY_LIST['leggings'] << { "id" => sub.customer_id,
                                    "size" => my_size,
                                    "date" => sub['next_charge_scheduled_at'],
                                    "sub_id" => sub['subscription_id'],
                                   }
        end
      else
        next
      end
    rescue StandardError => e
      puts e.inspect
      puts line_item.inspect
      next
    end
  end
end

puts my_inventory.inspect
# change MY_LIST['key'] to matched uncommented missing_*: my_hash['size'] attribute value

  # MY_LIST['leggings'].each do |my_hash|
  #   cust = Customer.find(my_hash['id'])
  #   Report.find_or_create_by(email: cust.email)
  #   .update_attributes({
  #         first_name: cust.first_name,
  #         last_name: cust.last_name,
  #         shopify_customer_id: cust.shopify_customer_id,
  #         # missing_sports_jacket: my_hash['size'],
  #         missing_legging: my_hash['size'],
  #         # missing_sports_bra: my_hash['size'],
  #         next_charge_scheduled_at: my_hash['date'],
  #         subscription_id: my_hash['sub_id'],
  #       })
  # end
