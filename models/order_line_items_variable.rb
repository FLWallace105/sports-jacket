require_relative 'application_record'

class OrderLineItemsVariable < ActiveRecord::Base
  include ApplicationRecord
  self.table_name = 'order_line_items_variable'
  belongs_to :subscription
  belongs_to :order
end