#!/bin/ruby

require_relative '../../config/environment'

month_start = Time.local(2018, 12)
month_end = month_start.end_of_month
base_tag = { active_start: month_start, active_end: month_end }
early_tag = { active_start: nil, active_end: month_end }

# sunset the old tags without an active_end
ProductTag.where(active_end: nil).update_all(active_end: month_start - 1.second)

# main: Street Smarts
main_3 = 1607819821107
main_5 = 1607819886643
#Can't find them on EllieStaging
main_3_autorenew = 1607881850931
main_5_autorenew = 1607883882547


ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: main_5_autorenew, tag: 'switchable')


#Prepaid

prepaid_1 = 614485950496
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_1, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_1, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_1, tag: 'switchable').update(early_tag)




# alt 1 Blush Crush
alt1_3 = 1607818182707
alt1_5 = 1607818248243
alt1_3_autorenew = 1607897317427
alt1_5_autorenew = 1607900201011

ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_5_autorenew, tag: 'current')


# alt 2 Snug Life
alt2_3 = 1607818903603
alt2_5 = 1607819034675
alt_2_3_autorenew = 1607886929971
alt_2_5_autorenew = 1607894040627

ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_5_autorenew, tag: 'current')


#Alt 3 Never Basic
alt3_3 = 1612238389299
alt3_5 = 1612240027699
alt3_3_autorenew = 1612245205043
alt3_5_autorenew = 1612245631027

ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_5_autorenew, tag: 'current')

#Street Smarts 2
# main: Street Smarts
street2_3 = 1612430737459
street2_5 = 1612432703539
street2_3_autorenew = 1612546703411
street2_5_autorenew = 1612548079667



ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5_autorenew, tag: 'switchable').update(early_tag)

