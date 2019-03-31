require 'sinatra'
require 'rspec'
require 'rack/test'
require_relative '../api/ellie_listener.rb'
require_relative '../worker/resque_change_sizes.rb'
require_relative '../worker/resque_change_prepaid_sizes.rb'

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
    context "no_queued_not_charged" do
      it "returns the subscription product_collection" do
        cust = FactoryBot.create(:customer)
        my_sub = FactoryBot.create(
          :subscription_with_line_items,
          product_title: "Mauve Muse - 3 Items",
          next_charge_scheduled_at: "2019-03-10 00:00:00",
          customer_id: cust.customer_id,
        )
        expect(my_sub).to be_valid
        get "/subscriptions_properties", shopify_id: cust.shopify_customer_id
        puts last_response.body
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

  describe "PUT #/subscription/:subscription_id/sizes" do
    before do
      ResqueSpec.reset!
    end
    def create_prepaid_orders(my_customer, sub_id)
      start_date = Date.today + 1 << 1
      odr1 = FactoryBot.create(
        :order,
        customer_id: my_customer.customer_id,
        sub_id: sub_id,
        status: 'SUCCESS',
        is_prepaid: 0,
        scheduled_at: start_date,
        shipping_date: start_date,
        first_name: my_customer.first_name,
        last_name: my_customer.last_name,
      )
      odr2 = FactoryBot.create(
        :order,
        customer_id: my_customer.customer_id,
        sub_id: sub_id,
        first_name: my_customer.first_name,
        last_name: my_customer.last_name,
        scheduled_at: start_date >> 1,
        shipping_date: start_date >> 1,
      )
      odr3 = FactoryBot.create(
        :order,
        customer_id: my_customer.customer_id,
        sub_id: sub_id,
        scheduled_at: start_date >> 2,
        shipping_date: start_date >> 2,
        first_name: my_customer.first_name,
        last_name: my_customer.last_name,
      )
      return { :s1 => odr1, :q1 => odr2, :q2 => odr3, }
    end
    let(:sub) {FactoryBot.create(:subscription_with_line_items)}
    let(:new_sizes) {{"gloves"=>"XS", "leggings"=>"XS", "sports-bra"=>"XS", "tops"=>"XS"}}
    let(:params) {{leggings: 'XS', :'sports-bra' => 'XS', tops: 'XS', gloves: 'XS',}}
    let(:cust) {FactoryBot.create(:customer)}
    let(:base_date) { Date.today + 1 << 1 }

    context "regular subscription" do
      it "#sizes_change locally" do
        put "/subscription/#{sub.id}/sizes", params.to_json
        expect(sub.reload.sizes).to eq(new_sizes)
      end
      it "enqueues ChangeSizes" do
        put "/subscription/#{sub.id}/sizes", params.to_json
        expect(ChangeSizes).to have_queued(sub.id, new_sizes).in(:change_sizes)
      end
      it "raises error without sizes param" do
        put "/subscription/#{sub.id}/sizes"
        expect(last_response.status).to eq 400
      end
    end
    context "prepaid subscription", :focus do
      it "sizes_change sub + queued orders" do
        prepaid_sub = FactoryBot.create(
          :subscription_with_line_items,
          customer_id: cust.customer_id,
          next_charge_scheduled_at: base_date >> 3,
        )
        prepaid_sub.line_items[0].name = "product_id"
        prepaid_sub.line_items[0].value = sub.shopify_product_id
        pre_orders = create_prepaid_orders(cust, prepaid_sub.id)

        put "/subscription/#{prepaid_sub.id}/sizes", params.to_json
        expect(prepaid_sub.reload.sizes).to eq(new_sizes)
        expect(pre_orders[:q1].reload.sizes(prepaid_sub.id.to_s)).to eq(new_sizes)
        expect(pre_orders[:q2].reload.sizes(prepaid_sub.id.to_s)).to eq(new_sizes)
      end
    end
  end

  describe "GET /subscription/:subscription_id/sizes", :focus do
    let(:sub) {FactoryBot.create(:subscription_with_line_items)}
    let(:new_sizes) {{"leggings"=>"XS", "sports-bra"=>"XS", "tops"=>"XS", "gloves"=>"XS"}}
    let(:params) {{leggings: 'XS', :'sports-bra' => 'XS', tops: 'XS', gloves: 'XS',}}
    context "prepaid sub" do
      it "returns 200 with glove size" do
        put "/subscription/#{sub.id}/sizes", params.to_json
        get "/subscription/#{sub.id}/sizes"
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq(new_sizes.to_json)
      end

      it "returns 200 w/o glove size" do
        get "/subscription/#{sub.id}/sizes"
        expect(last_response.body).to eq sub.sizes.to_json
        expect(last_response.status).to eq 200
      end
      context "subscription not found" do
        it "returns error" do
          get "/subscription/#{11111111}/sizes"
          expect(last_response.status).not_to eq 200
        end
      end
    end
  end

end
