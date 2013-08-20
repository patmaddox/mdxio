require 'sinatra'
require './environment'
require './models/contact'

post '/twilio_callback' do
  Twilio::Verb.dial ENV['MY_PHONE_NUMBER']
end

get '/' do
  'I am Pat Maddox'
end
