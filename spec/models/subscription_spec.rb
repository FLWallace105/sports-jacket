require 'sinatra'
require 'rspec'
require 'rack/test'
require_relative '../../api/ellie_listener.rb'

RSpec.describe Subscription, "#result", :focus do
  it "returns boolean describing its active status" do
    sub = Subscription.find(29668047)
    expect(sub.prepaid?).to eq(true)
  end
end
