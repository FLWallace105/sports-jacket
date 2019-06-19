require_relative 'resque_helper'
require 'sendgrid-ruby'

class SendEmailToCustomer
    extend ResqueHelper
    include Logging
    include SendGrid

    @queue = 'send_customer_confirmation'

    def self.perform(params)
        Resque.logger = Logger.new("#{Dir.getwd}/logs/send_emails_resque.log")
        puts params.inspect
        Resque.logger.info params.inspect

        subscription_id = params['subscription_id']
        myaction = params['action']
        details = params['details']

        puts "subscription_id = #{subscription_id}"
        Resque.logger.info "subscription_id = #{subscription_id}"
        subscription = Subscription.find(subscription_id)
        Resque.logger.info "Subscription is #{subscription.inspect}"
        puts "Subscription is #{subscription.inspect}"
        customer_id = subscription.customer_id
        puts "Customer_id = #{customer_id}"
        mycustomer = Customer.find(customer_id)
        puts mycustomer.inspect

        first_name = mycustomer.first_name
        last_name = mycustomer.last_name
        email = mycustomer.email

        from = Email.new(email: 'no-reply@ellie.com', name: 'Ellie')
        to = Email.new(email: email)
        personalization = Personalization.new
        personalization.add_to(to)
        case myaction
            when 'change_sizes'
                puts "changing sizes"
                leggings = "Leggings: #{details['leggings']}"
                tops = "Top Size: #{details['tops']}"
                product_collection = "Product Collection: #{params['product_collection']}"
                if details.key?('sports-jacket')
                  jacket_or_bra = "Sports Jacket Size: #{details['sports-jacket']}"
                elsif details.key?('sports-bra')
                  jacket_or_bra = "Sports Bra Size: #{details['sports-bra']}"
                end
                subject = "Confirmation of Size Change for Your Subscription"
                personalization.add_dynamic_template_data({
                  "first_name" => first_name,
                  "last_name" => last_name,
                  "leggings" => leggings,
                  "tops" => tops,
                  "jacket_or_bra" => jacket_or_bra,
                  "product_collection" => product_collection,
                })
            when 'switching_product'
                puts "switching product"
                Resque.logger.debug "switching_product email processing..."
                my_details = "Your new subscription is for: #{details['product_title']}"
                puts "my_details for content = #{my_details}"
                mybody = "Dear #{first_name} #{last_name}:\n\n Here is your confirmation of the change to your subscription:\n\n #{my_details} \n\n Your friends at Ellie."
                subject = "Confirmation of Switching Your Subscription"
                content = Content.new(type: 'text/plain', value: mybody)
            when 'skipping'
                puts "skipping this month"
                #Skip Month code here
                puts "details = #{details.inspect}"
                new_charge_date = details['date']
                puts "new_charge_date = #{new_charge_date}"

                my_details = "Your new charge date is: #{new_charge_date}"
                mybody = "Dear #{first_name} #{last_name}:\n\n Here is your confirmation of the new charge date for your subscription:\n\n #{my_details} \n\n Your friends at Ellie."
                subject = "Confirmation of Skip for Your Subscription"
                content = Content.new(type: 'text/plain', value: mybody)
                puts "All done sending email"
                Resque.logger.info "all done sending email"
            else
                puts "Doing nothing"
        end

        begin
            mail = SendGrid::Mail.new
            mail.from = from
            mail.subject = subject
            mail.add_personalization(personalization)
            mail.template_id = 'd-2bd8b79ad88b40d7a3c5eb5504de33a1'
            sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
            response = sg.client.mail._('send').post(request_body: mail.to_json)
            puts response.headers
            Resque.logger.debug "Send grid response code: #{response.status_code}"
            Resque.logger.debug response.inspect
        rescue Exception => e
            Resque.logger.error(e.inspect)
        else
            puts "Email sent to customer!"
        end

    end
end

class SendEmailToCS
    extend ResqueHelper
    include Logging
    include SendGrid

    @queue = 'send_cs_error_email'
    def self.perform(params)
        puts "Sending to Customer Service"
        puts params.inspect
        subscription_id = params['subscription_id']
        myaction = params['action']
        details = params['details'].to_json
        subscription = Subscription.find(subscription_id)
        subscription_product_title = subscription.product_title
        customer_id = subscription.customer_id
        mycustomer = Customer.find(customer_id)
        puts mycustomer.inspect
        customer_name = "#{mycustomer.first_name} #{mycustomer.last_name}"
        puts customer_name.inspect

        mybody = "Dear Customer Service: \n\n The subscription: \n\n #{subscription_product_title}\n\n for customer:\n\n #{customer_name}\n\n was trying to do: #{myaction}\n\n with details: #{details}\n\n BUT SOMETHING WENT WRONG."

        from = Email.new(email: 'no-reply@ellie.com', name: 'Ellie')
        subject = "Subscription update error"
        to = Email.new(email: 'help@ellie.com')
        content = Content.new(type: 'text/plain', value: mybody)

        begin
            mail = Mail.new(from, subject, to, content)
            sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
            response = sg.client.mail._('send').post(request_body: mail.to_json)
            puts response.headers
        rescue Exception => e
            Resque.logger.error(e.inspect)
        else
            puts "Email sent to customer service."
        end





    end
end
