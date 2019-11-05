#!/bin/ruby

require_relative '../../config/environment'

<<<<<<< HEAD
month_start = Time.local(2019, 02)
=======
month_start = Time.local(2019, 1)
>>>>>>> master
month_end = month_start.end_of_month
base_tag = { active_start: month_start, active_end: month_end }
early_tag = { active_start: nil, active_end: month_end }

# sunset the old tags without an active_end
<<<<<<< HEAD
# ProductTag.where(active_end: nil).update_all(active_end: month_start - 1.second)

# feb_collection: Steel the Show
steel_3 = 2267622539322
steel_5 = 2267625160762
steel_3_autorenew = 2274396962874
steel_5_autorenew = 2269928226874


ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_5_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: steel_5_autorenew, tag: 'switchable')


# Prepaid
prepaid_3 = 2209786298426
prepaid_5 = 2209789771834
prepaid_3_autorenew = 2243360030778
prepaid_5_autorenew = 2243359604794


ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5_autorenew, tag: 'switchable').update(early_tag)

# feb_collection: Chill Mode
chill_3 = 2267626373178
chill_5 = 2267630239802
chill_3_autorenew = 2269927604282
chill_5_autorenew = 2269925670970


ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_5_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: chill_5_autorenew, tag: 'switchable')

# feb_collection: Flower Bud
flower_3 = 2267632697402
flower_5 = 2267637678138
flower_3_autorenew = 2269884219450
flower_5_autorenew = 2269928783930


ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_5_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: flower_5_autorenew, tag: 'switchable')

# feb_collection: The Jet Set
jet_3 = 2267638857786
jet_5 = 2267639349306
jet_3_autorenew = 2269845520442
jet_5_autorenew = 2269851156538


ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_5_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: jet_5_autorenew, tag: 'switchable')

# feb_collection: Morning Mantra
morning_3 = 2267641151546
morning_5 = 2267641872442
morning_3_autorenew = 2269929144378
morning_5_autorenew = 2269929701434


ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_3_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_5_autorenew, tag: 'skippable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_3_autorenew, tag: 'switchable')
ProductTag.create_with(early_tag).find_or_create_by(product_id: morning_5_autorenew, tag: 'switchable')
=======
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
>>>>>>> master
