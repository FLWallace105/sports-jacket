class OrderLineItem < ActiveRecord::Base
  include ApplicationRecord
  belongs_to :order
end
