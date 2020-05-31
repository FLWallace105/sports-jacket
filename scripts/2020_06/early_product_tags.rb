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

#Ellie Picks
ellie_pick2 = 4399742615610
ellie_pick3 = 4399742746682
ellie_pick5 = 4399742910522

# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick5, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick5, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ellie_pick5, tag: 'switchable').update(early_tag)




# May Collection: Fresh Tone
fresh_2 = 4465955569722
fresh_3 = 4465956257850
fresh_5 = 4465957109818
fresh_2_autorenew = 4471419174970
fresh_3_autorenew = 4471419437114
fresh_5_autorenew = 4471419797562
 
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: fresh_5_autorenew, tag: 'switchable').update(early_tag)


# May collection: Mineral Love
mineral_2 = 4465957797946
mineral_3 = 4465958387770
mineral_5 = 4465961369658
mineral_2_autorenew = 4471427629114
mineral_3_autorenew = 4471428055098
mineral_5_autorenew = 4471428251706
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mineral_5_autorenew, tag: 'switchable').update(early_tag)


# May collection: Coastal Cool
coastal_2 = 4465961861178
coastal_3 = 4465962647610
coastal_5 = 4465964286010
coastal_2_autorenew = 4471555326010
coastal_3_autorenew = 4471556374586
coastal_5_autorenew = 4471557619770
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: coastal_5_autorenew, tag: 'switchable').update(early_tag)


# May collection: Off the Grid
grid_2 = 4465968578618
grid_3 = 4465970839610
grid_5 = 4465974837306
grid_2_autorenew = 4471585013818
grid_3_autorenew = 4471586684986
grid_5_autorenew = 4471588978746

# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: grid_5_autorenew, tag: 'switchable').update(early_tag)


# May collection: Papaya Summer
summer_2 = 4466290032698
summer_3 = 4466290720826
summer_5 = 4466293407802
summer_2_autorenew = 4471633477690
summer_3_autorenew = 4471635574842
summer_5_autorenew = 4471636623418
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_5_autorenew, tag: 'current').update(early_tag)

# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: summer_5_autorenew, tag: 'switchable').update(early_tag)

#May Collection
#Cloud Nine
nine_2 = 4466295210042
nine_3 = 4466295406650
nine_5 = 4466296094778
nine_2_autorenew = 4471428743226
nine_3_autorenew = 4471429627962
nine_5_autorenew = 4471430283322
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: nine_5_autorenew, tag: 'switchable').update(early_tag)


#May Collection
#Roll the Dye
dye_2 = 4466297176122
dye_3 = 4466297929786
dye_5 = 4466299371578
dye_2_autorenew = 4471431659578
dye_3_autorenew = 4471433461818
dye_5_autorenew = 4471433723962
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dye_5_autorenew, tag: 'switchable').update(early_tag)


#May Collection
#Windbreaker
wind_2 = 4466299830330
wind_3 = 4466300452922
wind_5 = 4466302419002
wind_2_autorenew = 4471434379322
wind_3_autorenew = 4471435395130
wind_5_autorenew = 4471618469946
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wind_5_autorenew, tag: 'switchable').update(early_tag)


#May Collection
#Peachy Keen
peachy_2 = 4466303500346
peachy_3 = 4466303762490
peachy_5 = 4466305335354
peachy_2_autorenew = 4471653138490
peachy_3_autorenew = 4471654154298
peachy_5_autorenew = 4471654678586
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: peachy_5_autorenew, tag: 'switchable').update(early_tag)

#May Collection
#Emerald Tide
emerald_2 = 4466306121786
emerald_3 = 4466306613306
emerald_5 = 4466306973754
emerald_2_autorenew = 4471660707898
emerald_3_autorenew = 4471457349690
emerald_5_autorenew = 4471661494330
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: emerald_5_autorenew, tag: 'switchable').update(early_tag)

