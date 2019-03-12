#!/bin/ruby
# products must be manually tagged FIRST
# according to specs in worker/monthly_setup.rb
require_relative '../../config/environment'
#@month = Date.today >> 1 # set up for next month
@month = Date.today #set up for this month
month_start = Time.local("#{@month.strftime('%Y')}", "#{@month.strftime('%m')}")
month_end = month_start.end_of_month
early_tag = { active_start: nil, active_end: month_end }
# sunset the old tags without an active_end
# ProductTag.where(active_end: nil).update_all(active_end: month_start - 1.second)
my_tag = "%#{@month.strftime('%m%y')}_collection%"
# main: prepaid products (CURRENTLY TEST VALUES)
prepaid_3 = 1635509436467
prepaid_5 = 1635509469235
prepaid_3_autorenew = 1421105004595
prepaid_5_autorenew = 1421098450995

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'prepaid')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'prepaid')
  .update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'current')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'current')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'current')
  .update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'current')
  .update(early_tag)

  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'skippable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'skippable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'skippable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'skippable')
    .update(early_tag)

  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'switchable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'switchable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'switchable')
    .update(early_tag)
  ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'switchable')
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
