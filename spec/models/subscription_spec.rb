require 'sinatra'
require 'rspec'
require 'factory_bot'
require 'rack/test'
require_relative '../../api/ellie_listener.rb'

RSpec.describe Subscription, :focus do
  describe "#prepaid?"
  let(:sub) { build(:subscription) }

  context "when Subscription is active" do
    it "returns true" do
      expect(sub.raw_line_item_properties).to eq("leggings")
    end
  end

  context "when Subscription is inactive" do
    it "returns false" do

    end
  end

end
