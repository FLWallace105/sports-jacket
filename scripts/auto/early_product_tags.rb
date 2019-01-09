#!/bin/ruby
# products must be manually tagged FIRST
# according to specs in worker/monthly_setup.rb
require_relative '../../config/environment'
# @month = Date.today >> 1 # set up for next month
@month = Date.today #set up for this month
month_start = Time.local("#{@month.strftime('%Y')}", "#{@month.strftime('%m')}")
month_end = month_start.end_of_month
early_tag = { active_start: nil, active_end: month_end }
# sunset the old tags without an active_end
# ProductTag.where(active_end: nil).update_all(active_end: month_start - 1.second)

# main: prepaid products (CURRENTLY TEST VALUES)
prepaid_3 = 1635509436467
prepaid_5 = 1635509469235
prepaid_3_autorenew = 1421105004595
prepaid_5_autorenew = 1421098450995

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'prepaid').update(early_tag)

# main Current month
main_3 = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_main_3%';").first.shopify_id
main_5 = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_main_5%';").first.shopify_id
main_3_autorenew = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_main_AR3%';").first.shopify_id
main_5_autorenew = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_main_AR5%';").first.shopify_id

ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3,
  tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5,
  tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3,
  tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5,
  tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3,
  tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5,
  tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5_autorenew, tag: 'switchable')

# alt 1 Current month
alt1_3 = Product.find_by_sql("SELECT shopify_id from products where tags
  LIKE '%#{@month.strftime('%m%y')}_alt1_3%';").first.shopify_id
alt1_5 = Product.find_by_sql("SELECT shopify_id from products where tags
  LIKE '%#{@month.strftime('%m%y')}_alt1_5%';").first.shopify_id
alt1_3_autorenew = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_alt1_AR3%';").first.shopify_id
alt1_5_autorenew = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_alt1_AR5%';").first.shopify_id
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_5_autorenew, tag: 'current')

# alt 2 Current month
alt2_3 = Product.find_by_sql("SELECT shopify_id from products where tags
  LIKE '%#{@month.strftime('%m%y')}_alt2_3%';").first.shopify_id
alt2_5 = Product.find_by_sql("SELECT shopify_id from products where tags
  LIKE '%#{@month.strftime('%m%y')}_alt2_5%';").first.shopify_id
alt2_3_autorenew = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_alt2_AR3%';").first.shopify_id
alt2_5_autorenew = Product.find_by_sql("SELECT shopify_id from products where tags LIKE '%#{@month.strftime('%m%y')}_alt2_AR5%';").first.shopify_id
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_5_autorenew, tag: 'current')
