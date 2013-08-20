require 'twilio'
require 'active_record'

Twilio.connect ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
