class MainController < ApplicationController
  def home
    render :text => 'I am Pat Maddox'
  end

  def twilio_callback
    render :text => Twilio::Verb.dial ENV['MY_PHONE_NUMBER']
  end
end