#!/bin/ruby
# ELLIE LIVE
require_relative '../../config/environment'

month_start = Time.local(2020, 2)
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


# Feb Collection: Super Nova
supernova_2 = 4382368825402
supernova_3 = 4382368890938
supernova_5 = 4382369349690
supernova_2_autorenew = 4385224261690
supernova_3_autorenew = 4385224523834
supernova_5_autorenew = 4385224917050
 
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: supernova_5_autorenew, tag: 'switchable').update(early_tag)


# Feb collection: Hidden Gem
hidden_2 = 4382369808442
hidden_3 = 4382369906746
hidden_5 = 4382370824250
hidden_2_autorenew = 4385225015354
hidden_3_autorenew = 4385225637946
hidden_5_autorenew = 4385225867322
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: hidden_5_autorenew, tag: 'switchable').update(early_tag)


# Feb collection: Bayside Breeze
bay_2 = 4382371348538
bay_3 = 4382371840058
bay_5 = 4382372233274
bay_2_autorenew = 4385568751674
bay_3_autorenew = 4385568817210
bay_5_autorenew = 4385515929658
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: bay_5_autorenew, tag: 'switchable').update(early_tag)


# Feb collection: Cupid's Kiss
cupid_2 = 4382377443386
cupid_3 = 4382378229818
cupid_5 = 4382378360890
cupid_2_autorenew = 4385568555066
cupid_3_autorenew = 4385568620602
cupid_5_autorenew = 4385568718906

# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: cupid_5_autorenew, tag: 'switchable').update(early_tag)


# Feb collection: Knockout
knockout_2 = 4382379376698
knockout_3 = 4382379475002
knockout_5 = 4382379999290
knockout_2_autorenew = 4385566261306
knockout_3_autorenew = 4385566359610
knockout_5_autorenew = 4385229602874
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_5_autorenew, tag: 'current').update(early_tag)

# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: knockout_5_autorenew, tag: 'switchable').update(early_tag)

#Feb Collection
#Ready Set Go
ready_2 = 4383945261114
ready_3 = 4385207582778
ready_5 = 4385217249338
ready_2_autorenew = 4385510817850
ready_3_autorenew = 4385511407674
ready_5_autorenew = 4385512390714
# set current tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_2, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_2_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_5_autorenew, tag: 'current').update(early_tag)
# set skippable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_2, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_2_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_5_autorenew, tag: 'skippable').update(early_tag)
# set switchable tags
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_2, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_5, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_2_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: ready_5_autorenew, tag: 'switchable').update(early_tag)

#Out of the Blue
blue_2 = 4385218494522
blue_3 = 4385218953274
blue_5 = 4385220067386
blue_2_autorenew = 4385513144378
blue_3_autorenew = 4385565573178
blue_5_autorenew = 4385565769786
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



