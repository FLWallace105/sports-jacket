#log_rollover.rb
require 'aws-sdk-s3'
require 'dotenv'
Dotenv.load

module EllieLog
    class Rollover

        def initialize
            @aws_key = ENV['AWS_KEY']
            @aws_secret_key= ENV['AWS_SECRET_KEY']

        end

        def start_log_rollover
            
            puts __dir__
            
            temp_files_array = Array.new
            my_files = Dir.entries("/home/floyd/sports-jacket/logs").select {|f| !File.directory? f}
            my_files.each do |myf|
                puts myf.inspect
                
                temp_files_array << myf
            end
            puts temp_files_array.inspect
            

            #arn:aws:s3:::fam-production-logs

            Aws.config.update({
                credentials: Aws::Credentials.new(@aws_key, @aws_secret_key)
             })
            s3 = Aws::S3::Resource.new(region: 'us-east-1')
            bucket = 'fam-production-logs'

            my_date = Date.today.strftime("%Y-%m-%d")
            my_date_string = "_#{my_date}.log"
            temp_files_array.each do |tempfile|
                local_file = "/home/floyd/sports-jacket/logs/#{tempfile}"
                remote_file = tempfile.gsub(/\.log/i, my_date_string)
                remote_file_path = 'exports/' + remote_file
                puts local_file
                puts remote_file_path
                obj = s3.bucket(bucket).object(remote_file_path)
                obj.upload_file(local_file)
                puts obj.inspect

            end
            puts "All Done! with Uploading"

            #File.delete(path_to_file) if File.exist?(path_to_file)
            temp_files_array.each do |tempfile|
                local_file = "/home/floyd/sports-jacket/logs/#{tempfile}"
                File.delete(local_file) if File.exist?(local_file)

            end
            puts "Done with deleting files, exiting now"


            

        end


    end
end
