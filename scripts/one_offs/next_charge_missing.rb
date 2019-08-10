require_relative './id_file'
require_relative '../../api/config/environment'
require 'httparty'
require 'dotenv'
Dotenv.load

class SubFinder
  def initialize
    @recharge_token = ENV['RECHARGE_ACCESS_TOKEN']
    @recharge_change_header = {
      'X-Recharge-Access-Token' => @recharge_token,
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
    @bad_sub_map = {}
  end

  def query_recharge
    puts "querying recharge now..."
    bad_sub_ids = ID_LIST
    record = File.open("sub_record.txt", "a") do |f|
      bad_sub_ids.each do |sub_id|
        sub_response = HTTParty.get("https://api.rechargeapps.com/subscriptions/#{sub_id}", :headers => @recharge_change_header, :body => {}, :timeout => 80)
        my_sub = sub_response.parsed_response['subscription']
        next unless my_sub['next_charge_scheduled_at'] == nil && my_sub['status'] == 'ACTIVE'
        # puts "ID: #{my_sub['id']}, next_charge_scheduled_at: #{my_sub['next_charge_scheduled_at']}"
        @bad_sub_map["#{my_sub['id']}"] = my_sub
      end
    end
    return @bad_sub_map
  end

  def generate_report
    #Headers for CSV
    column_header = [
      "subscription_id", "next_charge_scheduled_at", "status",
      "expire_after_specific_number_of_charges", "has_queued_charges", "created_at",
      "updated_at", "json"
    ]
    #delete old file
    File.delete('no_next_charge_report.csv') if File.exist?('no_next_charge_report.csv')
    CSV.open('no_next_charge_report.csv','a+', :write_headers=> true, :headers => column_header) do |hdr|
      column_header = nil
      subMap = query_recharge
      puts "creating CSV.."
      subMap.each do |key, value|
        #Construct the CSV string
        subscription_id = key
        next_charge_scheduled_at = value['next_charge_scheduled_at']
        expire_after_specific_number_of_charges = value['expire_after_specific_number_of_charges']
        has_queued_charges = value['has_queued_charges']
        status = value['status']
        created_at = value['created_at'].strftime('%F')
        updated_at = value['updated_at'].strftime('%F')
        json = value

        csv_data_out = [
          subscription_id, next_charge_scheduled_at, status,
          expire_after_specific_number_of_charges, has_queued_charges,
          created_at, updated_at, json
        ]
        hdr << csv_data_out
      end
    end
    puts "ALL DONE"
  end

end

sub_map = SubFinder.new.generate_report
