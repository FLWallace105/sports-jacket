#!/bin/ruby

require_relative '../../config/environment'

month_start = Time.local(2019, 02)
month_end = month_start.end_of_month
base_tag = { active_start: month_start, active_end: month_end }
early_tag = { active_start: nil, active_end: month_end }

# sunset the old tags without an active_end
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


# feb_collection: True Blue (repeat)
true_blue_3 = 2226409963578
true_blue_5 = 2226391941178
true_blue_3_autorenew = 2237897441338
true_blue_5_autorenew = 2237898391610


ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_5_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: true_blue_5_autorenew, tag: 'switchable').update(early_tag)


# feb_collection: Wine & Roses (repeat)
wine_roses_3 = 2076495052858
wine_roses_5 = 2076520939578
wine_roses_3_autorenew = 2092149178426
wine_roses_5_autorenew = 2092150227002


ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_5, tag: 'switchable').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_3_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_5_autorenew, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_3_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_5_autorenew, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_3_autorenew, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: wine_roses_5_autorenew, tag: 'switchable').update(early_tag)
