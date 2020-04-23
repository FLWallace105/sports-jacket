#!/bin/ruby
# ELLIE LIVE
require_relative '../../config/environment'

month_start = Time.local(2020, 4)
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




# April Collection: Back to Basics
basic_2 = 4408141545530
basic_3 = 4408141643834
basic_5 = 4408142102586
basic_2_autorenew = 4412790439994
basic_3_autorenew = 4412790571066
basic_5_autorenew = 4412792012858
 
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: basic_5_autorenew, tag: 'switchable').update(early_tag)


# April collection: Dream On
dream_2 = 4408153636922
dream_3 = 4408153833530
dream_5 = 4408154161210
dream_2_autorenew = 4412798500922
dream_3_autorenew = 4412922724410
dream_5_autorenew = 4412923052090
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: dream_5_autorenew, tag: 'switchable').update(early_tag)


# April collection: kaleidoscope
k_2 = 4408154587194
k_3 = 4408154718266
k_5 = 4408154980410
k_2_autorenew = 4412923248698
k_3_autorenew = 4412923609146
k_5_autorenew = 4412923838522
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: k_5_autorenew, tag: 'switchable').update(early_tag)


# April collection: Violet Rhapsody
vr_2 = 4408177066042
vr_3 = 4408177164346
vr_5 = 4408177918010
vr_2_autorenew = 4413239951418
vr_3_autorenew = 4413241753658
vr_5_autorenew = 4413242769466

# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: vr_5_autorenew, tag: 'switchable').update(early_tag)


# April collection: Glow Getter
glow_2 = 4408155603002
glow_3 = 4408155701306
glow_5 = 4408176607290
glow_2_autorenew = 4412924133434
glow_3_autorenew = 4412932653114
glow_5_autorenew = 4413236379706
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_5_autorenew, tag: 'current').update(early_tag)

# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: glow_5_autorenew, tag: 'switchable').update(early_tag)

#April Collection
#Matcha Cha Cha
matcha_2 = 4408142331962
matcha_3 = 4408142463034
matcha_5 = 4408153047098
matcha_2_autorenew = 4412792864826
matcha_3_autorenew = 4412793323578
matcha_5_autorenew = 4412795584570
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: matcha_5_autorenew, tag: 'switchable').update(early_tag)


