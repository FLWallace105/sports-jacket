#!/bin/ruby
# ELLIE LIVE
require_relative '../../config/environment'

month_start = Time.local(2020, 3)
month_end = month_start.end_of_month
early_tag = { active_start: nil, active_end: month_end }


# Prepaid (current)
prepaid_3 = 2209786298426
prepaid_5 = 2209789771834
prepaid_3_autorenew = 2243360030778
prepaid_5_autorenew = 2243359604794
prepaid_2 = 2506238492730


# set prepaid tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'prepaid').update(early_tag)
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'current').update(early_tag)

# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'skippable').update(early_tag)

# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_2, tag: 'switchable').update(early_tag)
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


# Mar Collection: Blue Skies
blue_2 = 4398406959162
blue_3 = 4398408073274
blue_5 = 4398409089082
blue_2_autorenew = 4400082452538
blue_3_autorenew = 4400083140666
blue_5_autorenew = 4400083927098
 
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: blue_5_autorenew, tag: 'switchable').update(early_tag)


# Mar collection: Making Moves
making_2 = 4398463418426
making_3 = 4398463516730
making_5 = 4398463877178
making_2_autorenew = 4400104570938
making_3_autorenew = 4400104898618
making_5_autorenew = 4400109584442
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: making_5_autorenew, tag: 'switchable').update(early_tag)


# Mar collection: Under the Radar
under_2 = 4398464499770
under_3 = 4398464565306
under_5 = 4399643066426
under_2_autorenew = 4400084254778
under_3_autorenew = 4400086024250
under_5_autorenew = 4400098377786
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: under_5_autorenew, tag: 'switchable').update(early_tag)


# Mar collection: Bahama Babe
babe_2 = 4399644442682
babe_3 = 4399644639290
babe_5 = 4399644934202
babe_2_autorenew = 4400099196986
babe_3_autorenew = 4400100769850
babe_5_autorenew = 4402348621882

# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: babe_5_autorenew, tag: 'switchable').update(early_tag)


# MAr collection: Wave Runner
wave_2 = 4399737405498
wave_3 = 4399737798714
wave_5 = 4399737995322
wave_2_autorenew = 4400596811834
wave_3_autorenew = 4400597303354
wave_5_autorenew = 4402350161978
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_5_autorenew, tag: 'current').update(early_tag)

# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wave_5_autorenew, tag: 'switchable').update(early_tag)

#Mar Collection
#Queen Vibes
queen_2 = 4399738388538
queen_3 = 4399738585146
queen_5 = 4399738912826
queen_2_autorenew = 4400597598266
queen_3_autorenew = 4400597827642
queen_5_autorenew = 4400598155322
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: queen_5_autorenew, tag: 'switchable').update(early_tag)


