require 'sinatra'
require 'rspec'
require 'factory_bot'
require 'rack/test'
require_relative '../../api/ellie_listener.rb'

RSpec.describe Subscription, :focus do
  it "returns true if next QUEUED order.line_item properties 'product_id' is skippable/current" do
    cust = FactoryBot.create(:customer)
    sub = FactoryBot.create(:subscription_with_line_items, customer_id: cust.id)
    sub.line_items[0].name = "product_id"
    sub.line_items[0].value = sub.shopify_product_id

    order_1 = FactoryBot.create(
      :order,
      customer_id: cust.id,
      sub_id: sub.id,
      status: 'SUCCESS',
      is_prepaid: 0,
      scheduled_at: Date.today - 2,
    )
    order_2 = FactoryBot.create(
      :order,
      customer_id: cust.id,
      sub_id: sub.id,
      scheduled_at: Date.today >> 1
    )
    FactoryBot.create(:order, customer_id: cust.id, sub_id: sub.id)

    expect(sub.prepaid_skippable?).to be true
  end
end
