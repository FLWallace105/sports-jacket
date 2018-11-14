require_relative 'application_record'

class OrderShippingAddress < ActiveRecord::Base
  include ApplicationRecord
  self.table_name = 'order_shipping_address'
  belongs_to :subscription
  belongs_to :order
end