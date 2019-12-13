class SubscriptionProperty < ActiveRecord::Base
  include ApplicationRecord
  self.table_name = "subscription_properties"
end
