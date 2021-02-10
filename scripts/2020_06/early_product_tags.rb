#!/bin/ruby
# ELLIE LIVE
require_relative '../../config/environment'

month_start = Time.local(2020, 6)
month_end = month_start.end_of_month
early_tag = { active_start: nil, active_end: month_end }


# Prepaid (current)
prepaid_3 = 2209786298426
prepaid_5 = 2209789771834
prepaid_3_autorenew = 2243360030778
prepaid_5_autorenew = 2243359604794
# set prepaid tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'prepaid').update(early_tag)
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'switchable').update(early_tag)


# Prepaid (legacy)
old_3_months = 23729012754
vip_3_month = 9175678162
old_3_months_autorenew = 10301516626
# set prepaid tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vip_3_month, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months_autorenew, tag: 'prepaid').update(early_tag)
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vip_3_month, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vip_3_month, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vip_3_month, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: old_3_months_autorenew, tag: 'switchable').update(early_tag)


# collection: Floral Bill
floral_2 = 4370204491915
floral_3 = 4370204688523
floral_5 = 4370204852363
floral_2_autorenew = 4410096353419
floral_3_autorenew = 4428955025547
floral_5_autorenew = 4428956926091
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_5_autorenew, tag: 'skippable').update(early_tag)

# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: floral_5_autorenew, tag: 'switchable').update(early_tag)



