# ELLIE STAGING
require_relative '../../config/environment'
@month = Time.now.localtime.to_date #set up for this month
@month2 = Time.now.localtime.to_date >> 1
 # set up for next month

month_start = Time.local("#{@month.strftime('%Y')}", "#{@month.strftime('%m')}")
month_end = month_start.end_of_month
next_month_end = Time.local("#{@month2.strftime('%Y')}", "#{@month2.strftime('%m')}").end_of_month

early_tag = { active_start: nil, active_end: month_end }
my_tag = "%#{@month.strftime('%m%y')}_collection%"
# my_tag = "%1019_collection%"

# Prepaid (current)
prepaid_2 = 2168707809331
prepaid_3 = 1421100974131
prepaid_5 = 1635509469235

# set prepaid tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid').update(early_tag)
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'switchable').update(early_tag)

# Prepaid (legacy)
prepaid_3_legacy = 1494813966387
# set prepaid tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'prepaid').update(early_tag)
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_legacy, tag: 'switchable').update(early_tag)

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
