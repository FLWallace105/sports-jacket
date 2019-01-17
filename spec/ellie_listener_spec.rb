require 'sinatra'
require 'rspec'
require 'rack/test'
require_relative '../api/ellie_listener.rb'

RSpec.describe EllieListener do
  include Rack::Test::Methods
  def app
    EllieListener
  end

  describe "#subscriptions_properties" do
    context "no sub_id param?" do
      it "returns 400 status code" do
        get "/subscriptions_properties"
        expect(last_response.status).to eq 400
      end
    end

    context "valid prepaid sub_id" do
      it "returns properties of next queued order or current order" do
        cust = FactoryBot.create(:customer)
        sub = FactoryBot.create(:subscription_with_line_items, customer_id: cust.id)
        sub.line_items[0].name = "product_id"
        sub.line_items[0].value = sub.shopify_product_id
        3.times do
          ord = FactoryBot.create(:order, customer_id: cust.id, sub_id: sub.id)
        end
        my_order = Order.find_by(customer_id: cust.id)
        my_order.status = "SUCCESS"
        my_order.is_prepaid = 1
        my_order.scheduled_at = Date.today - 1
        get "/subscriptions_properties", :shopify_id => cust.shopify_customer_id
        # expect(last_response.body).to eq(last_response.body)
      end
    end

  end


end
