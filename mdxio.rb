require 'sinatra'
require 'twilio'

Twilio.connect ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']

get '/twilio_callback' do
  Twilio::Verb.dial ENV['MY_PHONE_NUMBER']
end

get '/' do
  'I am Pat Maddox'
end
