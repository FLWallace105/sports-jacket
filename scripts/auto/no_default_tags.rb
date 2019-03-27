#!/bin/ruby
# products must be manually tagged FIRST
# according to specs in worker/monthly_setup.rb
require_relative '../../config/environment'
@month = Date.today #set up for this month
@month2 = Date.today >> 1 # set up for next month

month_start = Time.local("#{@month.strftime('%Y')}", "#{@month.strftime('%m')}")
month_end = month_start.end_of_month
next_month_end = Time.local("#{@month2.strftime('%Y')}", "#{@month2.strftime('%m')}").end_of_month

early_tag = { active_start: nil, active_end: next_month_end }
# sunset the old tags without an active_end
# ProductTag.where(active_end: nil).update_all(active_end: month_start - 1.second)
my_tag = "%#{@month2.strftime('%m%y')}_collection%"
# main: prepaid products
prepaid_3 = 1421100974131
prepaid_5 = 1635509469235
prepaid_3_legacy = 1494813966387

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'prepaid')
  .update(early_tag)
  .update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'current')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'current')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'current')
  .update(early_tag)
  .update(early_tag)

  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'skippable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'skippable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'skippable')
    .update(early_tag)
    .update(early_tag)

  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'switchable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'switchable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'switchable')
    .update(early_tag)
    .update(early_tag)


monthly_product_ids = Product.where("tags LIKE ?", my_tag ).pluck(:shopify_id)
puts "my ids: #{monthly_product_ids}"

monthly_product_ids.each do |current_id|
  ProductTag.create_with(early_tag).find_or_create_by(product_id: current_id, tag: 'current')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: current_id, tag: 'skippable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: current_id, tag: 'switchable')
    .update(early_tag)
end
