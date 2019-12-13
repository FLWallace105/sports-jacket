require 'sinatra'
require 'rspec'
require 'factory_bot'
require 'rack/test'
require_relative '../../worker/line_item_converter.rb'

RSpec.describe 'LineItemConverter', :focus do
  ORDER_JSON = File.read("#{Dir.getwd}/spec/factories/order_line_items.json")
  SUB_JSON = File.read("#{Dir.getwd}/spec/factories/subscription_props.json")
  let(:converter) { LineItemConverter }
  context "#dejsonify" do
    it "ORDER: returns an Array" do
      expect(converter.dejsonify(ORDER_JSON)).to be_a_kind_of(Array)
    end
    it "ORDER: returns all keys from JSON" do
      expect(converter.dejsonify(ORDER_JSON)[0].keys).to include(
        "price",
        "product_title",
        "quantity",
        "shopify_product_id",
        "shopify_variant_id",
        "sku",
        "subscription_id",
        "title",
        "charge_interval_frequency",
        "charge_interval_unit_type",
        "leggings",
        "main-product",
        "product_collection",
        "product_id",
        "shipping_interval_frequency",
        "shipping_interval_unit_type",
        "sports-bra",
        "tops",
        "sports-jacket",
        "variant_title",
        "referrer"
      )
    end
    it "SUB: returns an Array" do
      expect(converter.dejsonify(SUB_JSON)).to be_a_kind_of(Array)
    end
    it "SUB: returns all keys from JSON" do
      expect(converter.dejsonify(SUB_JSON)[0].keys).to include(
        "leggings",
        "sports-jacket",
        "tops",
        "sports-bra",
        "product_collection",
        "unique_identifier",
        "gloves"
      )
    end
  end

  context "ORDER" do
    # create order line item to send as an argument
    let (:o_line_item) { create(:order_line_item) }
    let (:order_json_resonse) { converter.jsonify(o_line_item, "order") }
    context "#jsonify" do
      it "returns JSON string" do
        expect(order_json_resonse).to be_a_kind_of(String)
      end
      it "response contains all arg keys" do
        res_hash = JSON.parse(order_json_resonse)
        expect(res_hash[0].keys).to include(
          "variant_id",
          "quantity",
          "product_title",
          "product_id",
          "variant_title",
          "properties"
        )
      end
    end
  end

  context "SUBSCRIPTION" do
    let (:sub_prop) { create(:subscription_property) }
    let (:sub_json_response) { converter.jsonify(sub_prop, "subscription") }
    context "#jsonify" do
      it "returns JSON string" do
        expect(sub_json_response).to be_a_kind_of(String)
      end
      it "has all arg keys in response" do
        res_keys = JSON.parse(sub_json_response).map{ |hsh| hsh['name'] }
        puts "SUB RESPONSE: #{res_keys.inspect}"
        expect(res_keys).to include(
          "product_collection",
          "leggings",
          "tops",
          "gloves",
          "sports-bra",
          "sports-jacket",
          "unique_identifier",
          "charge_interval_frequency",
          "charge_interval_unit_type",
          "main-product",
          "product_id",
          "referrer",
          "shipping_interval_frequency",
          "shipping_interval_unit_type"
        )
      end
    end
  end
end
