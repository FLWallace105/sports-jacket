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
      let(:base_date) { Date.today + 1 << 1 }
      it "returns properties of next queued order or current order" do
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
          shipping_date: base_date,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_2 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          first_name: cust.first_name,
          last_name: cust.last_name,
          scheduled_at: base_date >> 1,
          shipping_date: base_date >> 1,
        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          scheduled_at: base_date >> 2,
          shipping_date: base_date >> 2,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )

        my_order2 = Order.find(order_2.order_id)
        my_order3 = Order.find(order_3.order_id)
        my_title = ""
        my_order2.line_items[0]['properties'].each do |item|
          my_title = item['value'] if item['name'] == 'product_collection'
        end
        my_sub = Subscription.find(sub.id)

        get "/subscriptions_properties", :shopify_id => cust.shopify_customer_id

        res = JSON.parse(last_response.body)
        expect(res[0]['subscription_id']).to eq(my_sub.subscription_id.to_i)
        expect(res[0]['shopify_product_id']).to eq(my_sub.shopify_product_id.to_i)
        expect(res[0]['product_title']).to eq(my_title)
        expect(res[0]['next_charge']).to eq(
          my_sub.next_charge_scheduled_at.try{|time| time.strftime('%Y-%m-%d')}
        )
        expect(res[0]['sizes']).to eq(my_sub.sizes)
        expect(res[0]['prepaid']).to eq(true)
        expect(res[0]['skippable']).to eq(true)
        expect(res[0]['can_choose_alt_product']).to eq(true)
        expect(res[0]['next_ship_date']).to eq(
          my_order2.scheduled_at.try{|time| time.strftime('%Y-%m-%d')}
        )
      end
    end
    context "no queued orders" do
      let(:base_date) { Date.today + 1 << 3 }
      it "returns most recent order info" do
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
          shipping_date: base_date,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_2 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          first_name: cust.first_name,
          last_name: cust.last_name,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date >> 1,
          shipping_date: base_date >> 1,
        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date >> 2,
          shipping_date: base_date >> 2,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )

        get "/subscriptions_properties", :shopify_id => cust.shopify_customer_id

        my_order2 = Order.find(order_2.order_id)
        my_order3 = Order.find(order_3.order_id)
        my_title = ""
        my_order3.line_items[0]['properties'].each do |item|
          my_title = item['value'] if item['name'] == 'product_collection'
        end
        my_sub = Subscription.find(sub.id)
        res = JSON.parse(last_response.body)

        expect(res[0]['subscription_id']).to eq(my_sub.subscription_id.to_i)
        expect(res[0]['shopify_product_id']).to eq(my_sub.shopify_product_id.to_i)
        expect(res[0]['product_title']).to eq(my_title)
        expect(res[0]['next_charge']).to eq(
          my_sub.next_charge_scheduled_at.try{|time| time.strftime('%Y-%m-%d')}
        )
        expect(res[0]['sizes']).to eq(my_sub.sizes)
        expect(res[0]['prepaid']).to eq(true)
        expect(res[0]['skippable']).to eq(true)
        expect(res[0]['can_choose_alt_product']).to eq(true)
        expect(res[0]['next_ship_date']).to eq(
          my_sub.next_charge_scheduled_at.try{|time| time.strftime('%Y-%m-%d')}
        )
      end
    end
  end

  describe "PUT #subscription_switch" do
    context "when subscription is prepaid", :focus do
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
          next unless item["name"] == "product_collection"
          @prod_collection = item["value"]
        end
        puts "my subcription_id: #{sub.id}"
        puts "my order_2: #{current_order.inspect}"
        expect(@prod_collection).to eq(Product.find(params[:real_alt_product_id]).title)
      end
    end
    context "NO QUEUED ORDERS" do
      let(:base_date) { Date.today + 1 << 3 }
      it "switches subscriptions product_collection value" do
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
          shipping_date: base_date,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_2 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          first_name: cust.first_name,
          last_name: cust.last_name,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date >> 1,
          shipping_date: base_date >> 1,
        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date >> 2,
          shipping_date: base_date >> 2,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        params = {
          action: 'switch_product',
          subscription_id: sub.id,
          # 3 MONTH - 3 Items
          product_id: "1635509436467",
          # True Blue - 5 Items
          alt_product_id: "1663705514035",
          # True Blue - 3 Items
          real_alt_product_id: "1663704662067",
         }

        put "/subscription_switch", params
        my_collection = ""
        Subscription.find(sub.subscription_id).raw_line_item_properties.each do |item|
          next unless item['name'] == "product_collection"
          my_collection = item['value']
        end
        expect(my_collection).to eq(Product.find(params[:real_alt_product_id]).title)
      end
    end
  end

  describe "POST #subscription_skip" do
    let(:base_date) { Date.today + 1 << 3 }
    context "when subscription is prepaid" do
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
          scheduled_at: base_date >> 1,
          shipping_date: base_date >> 1,
        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          scheduled_at: base_date >> 2,
          shipping_date: base_date >> 2,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        my_sub_date = sub.next_charge_scheduled_at
        params = {
          action: 'skip_month',
          subscription_id: sub.id,
          shopify_customer_id: cust.shopify_customer_id,
          reason: "too_much_product",
         }

        post "/subscription_skip", params

        my_order2 = Order.find(order_2.order_id)
        my_order3 = Order.find(order_3.order_id)
        my_sub = Subscription.find_by(subscription_id: sub.id)

        expect(my_sub.next_charge_scheduled_at
          .try{ |time| time.strftime('%F %T') })
          .to eq((base_date >> 4).strftime('%F %T')
        )
        expect(my_order2.scheduled_at).to eq(base_date >> 2)
        expect(my_order3.scheduled_at).to eq(base_date >> 3)
      end
    end
    context "NO QUEUED ORDERS" do
      # let(:base_date) { Date.today + 1 << 3 }
      it "adds one month to subscription.next_charge_scheduled_at" do
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
          shipping_date: base_date,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        order_2 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          first_name: cust.first_name,
          last_name: cust.last_name,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date >> 1,
          shipping_date: base_date >> 1,
        )
        order_3 = FactoryBot.create(
          :order,
          customer_id: cust.customer_id,
          sub_id: sub.id,
          status: 'SUCCESS',
          is_prepaid: 0,
          scheduled_at: base_date >> 2,
          shipping_date: base_date >> 2,
          first_name: cust.first_name,
          last_name: cust.last_name,
        )
        old_skip_date = sub.next_charge_scheduled_at
        params = {
          action: 'skip_month',
          subscription_id: sub.id,
          shopify_customer_id: cust.shopify_customer_id,
          reason: "too_much_product",
         }

        post "/subscription_skip", params
        my_sub = Subscription.find(sub.id)
        puts "new skip date #{my_sub.next_charge_scheduled_at}"
        expect(my_sub.next_charge_scheduled_at).to eq(old_skip_date >> 1)
      end
    end
  end

  # describe "PUT #subscription/:subscription_id/sizes", :focus  do
  #   context "when subscription is prepaid" do
  #     let(:base_date) { Date.today + 1 << 1 }
  #     it "changes sub and queued order sizes" do
  #       cust = FactoryBot.create(:customer)
  #       sub = FactoryBot.create(
  #         :subscription_with_line_items,
  #         customer_id: cust.customer_id,
  #         next_charge_scheduled_at: base_date >> 3,
  #       )
  #       sub.line_items[0].name = "product_id"
  #       sub.line_items[0].value = sub.shopify_product_id
  #       order_1 = FactoryBot.create(
  #         :order,
  #         customer_id: cust.customer_id,
  #         sub_id: sub.id,
  #         status: 'SUCCESS',
  #         is_prepaid: 0,
  #         scheduled_at: base_date,
  #         first_name: cust.first_name,
  #         last_name: cust.last_name,
  #       )
  #       order_2 = FactoryBot.create(
  #         :order,
  #         customer_id: cust.customer_id,
  #         sub_id: sub.id,
  #         first_name: cust.first_name,
  #         last_name: cust.last_name,
  #         scheduled_at: base_date >> 1
  #       )
  #       order_3 = FactoryBot.create(
  #         :order,
  #         customer_id: cust.customer_id,
  #         sub_id: sub.id,
  #         scheduled_at: base_date >> 2,
  #         first_name: cust.first_name,
  #         last_name: cust.last_name,
  #       )
  #       my_body = { "leggings" => "XS", "sports-bra" => "XS", "tops" => "XS"}.to_json
  #
  #       put "/subscription/#{sub.id}/sizes", body: my_body
  #       my_order2 = Order.find(order_2.order_id)
  #       my_order3 = Order.find(order_3.order_id)
  #       my_sub = Subscription.find(sub.id)
  #       expect(last_response.body).to eq(last_response)
  #     end
  #   end
  # end


end
