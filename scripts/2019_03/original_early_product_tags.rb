#!/bin/ruby

require_relative '../../config/environment'

month_start = Time.local(2019, 03)
month_end = month_start.end_of_month
base_tag = { active_start: month_start, active_end: month_end }
early_tag = { active_start: nil, active_end: month_end }

# sunset the old tags without an active_end
# ProductTag.where(active_end: nil).update_all(active_end: month_start - 1.second)

# march_collection: Mauve Muse
mauve_3 = 1730319646771
mauve_5 = 1730319908915

ProductTag.create_with(early_tag).find_or_create_by(product_id: mauve_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mauve_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mauve_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mauve_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mauve_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: mauve_5, tag: 'switchable').update(early_tag)


# Prepaid
prepaid_3 = 1635509436467
prepaid_5 = 1635509469235

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'prepaid').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'prepaid').update(early_tag)

ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: prepaid_5, tag: 'switchable').update(early_tag)


# march_collection: First Impression
first_impression_3 = 1730317746227
first_impression_5 = 1730318663731

ProductTag.create_with(early_tag).find_or_create_by(product_id: first_impression_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: first_impression_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: first_impression_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: first_impression_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: first_impression_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: first_impression_5, tag: 'switchable').update(early_tag)


# march_collection: Starstruck
starstruck_3 = 1730322006067
starstruck_5 = 1730322300979

ProductTag.create_with(early_tag).find_or_create_by(product_id: starstruck_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: starstruck_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: starstruck_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: starstruck_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: starstruck_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: starstruck_5, tag: 'switchable').update(early_tag)


# march_collection: To the Limit
to_the_limit_3 = 1730323152947
to_the_limit_5 = 1730323677235

ProductTag.create_with(early_tag).find_or_create_by(product_id: to_the_limit_3, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: to_the_limit_5, tag: 'current').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: to_the_limit_3, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: to_the_limit_5, tag: 'skippable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: to_the_limit_3, tag: 'switchable').update(early_tag)
ProductTag.create_with(early_tag).find_or_create_by(product_id: to_the_limit_5, tag: 'switchable').update(early_tag)
