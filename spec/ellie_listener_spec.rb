require 'sinatra'
require 'rspec'
require 'rack/test'
require_relative '../api/ellie_listener.rb'

RSpec.describe EllieListener do
  include Rack::Test::Methods
  def app
    EllieListener
  end

  describe "#subscriptions_properties"  do
    context "no params['subcription_id']" do
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
          FactoryBot.create(:order,
                            customer_id: cust.id,
                            sub_id: sub.subscription_id,
                            first_name: cust.first_name,
                            last_name: cust.last_name,
                          )
        end
        my_order = Order.find_by(customer_id: cust.id)
        my_order.status = "SUCCESS"
        my_order.is_prepaid = 1
        my_order.scheduled_at = Date.today - 1
        puts "+++++++++++++++++++++++++++++++++my_order: #{my_order.inspect}"
        get "/subscriptions_properties", :shopify_id => cust.shopify_customer_id
        # expect(last_response.body).to eq(last_response.body)
      end
    end
  end

  describe "#subscription_switch",  :focus  do
    context "when subscription is prepaid" do
      it "switches next QUEUED Order.line_items product_collection" do
        cust = FactoryBot.create(:customer)
        sub = FactoryBot.create(:subscription_with_line_items, customer_id: cust.customer_id)
        sub.line_items[0].name = "product_id"
        sub.line_items[0].value = sub.shopify_product_id
        order_1 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.subscription_id,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: Date.today - 2,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_2 = FactoryBot.create(:order,
                          customer_id: cust.customer_id,
                          sub_id: sub.subscription_id,
                          first_name: cust.first_name,
                          last_name: cust.last_name,
                        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.subscription_id,
          scheduled_at: Date.today >> 1,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        params = {
          action: 'switch_product',
          subscription_id: sub.subscription_id,
          # 3 MONTH - 3 Items
          product_id: "1635509436467",
          # True Blue - 5 Items
          alt_product_id: "1663705514035",
          # True Blue - 3 Items
          real_alt_product_id: "1663704662067",
         }

        put "/subscription_switch", params
        current_order = Order.find(order_2.id)
        current_order.line_items[0]['properties'].each do |item|
          @prod_collection = item["value"] if item["name"] == "product_collection"
        end
        puts "my subcription_id: #{sub.id}"
        puts "my order_2: #{current_order.inspect}"
        expect(@prod_collection).to eq(Product.find(params[:real_alt_product_id]).title)
      end
    end
  end


end
