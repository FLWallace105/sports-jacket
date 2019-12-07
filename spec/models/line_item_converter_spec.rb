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
end
