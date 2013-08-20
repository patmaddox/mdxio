class MainController < ApplicationController
  protect_from_forgery :except => :twilio_callback

  def home
    render text: 'I am Pat Maddox'
  end

  def twilio_callback
    if Contact.whitelisted?(params['From'])
      render xml: Twilio::Verb.dial(ENV['MY_PHONE_NUMBER'])
    else
      render xml: Twilio::Verb.reject
    end
  end
end
