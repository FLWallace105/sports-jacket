require 'sinatra'
require 'rspec'
require 'factory_bot'
require 'rack/test'
require_relative '../../api/ellie_listener.rb'

RSpec.describe Subscription, :focus do
  context "When prepaid" do
    let(:cust) { FactoryBot.create(:customer) }
    let(:sub) { FactoryBot.create(:subscription_with_line_items, customer_id: cust.id) }
    let(:order_1) {  FactoryBot.create(
      :order,
      customer_id: cust.id,
      sub_id: sub.id,
      status: 'SUCCESS',
      is_prepaid: 0,
      scheduled_at: Date.today - 2,
      first_name: cust.first_name,
      last_name: cust.last_name,
      ) }
    let(:order_3) { FactoryBot.create(
      :order,
      customer_id: cust.id,
      sub_id: sub.id,
      scheduled_at: Date.today >> 1,
      first_name: cust.first_name,
      last_name: cust.last_name,
      ) }

    it "returns true if next QUEUED order hasnt been skipped" do
      FactoryBot.create(:order,
                        customer_id: cust.id,
                        sub_id: sub.id,
                        first_name: cust.first_name,
                        last_name: cust.last_name,
                       )
      sub.line_items[0].name = "product_id"
      sub.line_items[0].value = sub.shopify_product_id
      expect(sub.prepaid_skippable?).to be true
    end

    it "returns false if next QUEUED order hasnt been switched" do
      FactoryBot.create(:order, customer_id: cust.id, sub_id: sub.id)
      sub.line_items[0].name = "product_id"
      sub.line_items[0].value = sub.shopify_product_id
      expect(sub.prepaid_switched?).to be false
    end
  end
end
