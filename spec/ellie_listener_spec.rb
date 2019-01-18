require 'sinatra'
require 'rspec'
require 'rack/test'
require_relative '../api/ellie_listener.rb'

RSpec.describe EllieListener do
  include Rack::Test::Methods
  def app
    EllieListener
  end

  describe "GET #subscriptions_properties"  do
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

  describe "PUT #subscription_switch" do
    context "when subscription is prepaid" do
      let(:base_date) { Date.today + 1 << 1 }
      it "switches next QUEUED Order.line_items product_collection" do
        cust = FactoryBot.create(:customer)
        sub = FactoryBot.create(
          :subscription_with_line_items,
          customer_id: cust.customer_id,
          next_charge_scheduled_at: base_date >> 3,
        )
        sub.line_items[0].name = "product_id"
        sub.line_items[0].value = sub.shopify_product_id
        order_1 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.subscription_id,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_2 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.subscription_id,
          scheduled_at: base_date >> 1,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.subscription_id,
          scheduled_at: base_date >> 2,
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

  describe "POST #subscription_skip", :focus do
    context "when subscription is prepaid" do
      let(:base_date) { Date.today + 1 << 1 }
      it "advances sub and QUEUED orders dates 1 month" do
        cust = FactoryBot.create(:customer)
        sub = FactoryBot.create(
          :subscription_with_line_items,
          customer_id: cust.customer_id,
          next_charge_scheduled_at: base_date >> 3,
        )
        sub.line_items[0].name = "product_id"
        sub.line_items[0].value = sub.shopify_product_id
        order_1 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_2 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          first_name: cust.first_name,
          last_name: cust.last_name,
          scheduled_at: base_date >> 1
        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          scheduled_at: base_date >> 2,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        params = {
          action: 'skip_month',
          subscription_id: sub.id,
          shopify_customer_id: cust.shopify_customer_id,
          reason: "too_much_product",
         }
        my_sub_date = sub.next_charge_scheduled_at

        post "/subscription_skip", params
        my_order2 = Order.find(order_2.order_id)
        my_order3 = Order.find(order_3.order_id)
        my_sub = Subscription.find(sub.id)

        expect(my_sub.next_charge_scheduled_at).to eq(base_date >> 4)
        expect(my_order2.scheduled_at).to eq(base_date >> 2)
        expect(my_order3.scheduled_at).to eq(base_date >> 3)
      end
    end
  end

  describe "PUT #subscription/:subscription_id/sizes" do
    context "when subscription is prepaid" do
      it "changes sizes" do

      end
    end
  end


end
