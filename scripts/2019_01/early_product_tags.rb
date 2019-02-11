#!/bin/ruby

require_relative '../../config/environment'

month_start = Time.local(2019, 1)
month_end = month_start.end_of_month
base_tag = { active_start: month_start, active_end: month_end }
early_tag = { active_start: nil, active_end: month_end }

# sunset the old tags without an active_end
ProductTag.where(active_end: nil).update_all(active_end: month_start - 1.second)

# main: prepaid products (CURRENTLY TEST VALUES)
#prepaid_3 = 1421100974131
prepaid_5 = 23729012754
#prepaid_3_autorenew = 1421105004595
prepaid_5_autorenew = 10301516626

#ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid').update(early_tag)
#ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'prepaid').update(early_tag)



# main: Fierce & Floral
main_3 = 2227262881850
main_5 = 2227259342906
#Can't find them on EllieStaging
main_3_autorenew = 2236718448698
main_5_autorenew = 2237890625594


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



# alt 1 Knot Your Average
alt1_3 = 2227252559930
alt1_5 = 2227246661690
alt1_3_autorenew = 2237892132922
alt1_5_autorenew = 2237892952122

ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt1_5_autorenew, tag: 'current')



# alt 2 True Blue
alt2_3 = 2226409963578
alt2_5 = 2226391941178
alt_2_3_autorenew = 2237897441338
alt_2_5_autorenew = 2237898391610

ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_5_autorenew, tag: 'current')
#skippable
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_3, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_5, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_5_autorenew, tag: 'skippable')
#switchable
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_3, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt2_5, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt_2_5_autorenew, tag: 'switchable')


#Alt 3 Peace & Pastels
alt3_3 = 2226413174842
alt3_5 = 2226411667514
alt3_3_autorenew = 2237902815290
alt3_5_autorenew = 2237903110202

ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt3_5_autorenew, tag: 'current')

#Alt 4
# Street Dream
street2_3 = 1918042636346
street2_5 = 1918039687226
street2_3_autorenew = 1924806180922
street2_5_autorenew = 1924801101882

ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: street2_5_autorenew, tag: 'current').update(early_tag)


#Alt 5 Street Smarts2 -- changed
alt4_3 = 2188530778170
alt4_5 = 2188532875322
alt4_3_autorenew = 2196272807994
alt4_5_autorenew = 2188543328314

ProductTag.create_with(early_tag).find_or_create_by(product_id: alt4_3, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt4_5, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt4_3_autorenew, tag: 'current')
ProductTag.create_with(early_tag).find_or_create_by(product_id: alt4_5_autorenew, tag: 'current')