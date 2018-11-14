require_relative 'application_record'

class OrderBillingAddress < ActiveRecord::Base
  include ApplicationRecord
  self.table_name = 'order_billing_address'
  belongs_to :subscription
  belongs_to :order
end