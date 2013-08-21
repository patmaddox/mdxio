class MainController < ApplicationController
  protect_from_forgery except: [:twilio_callback]
  before_filter :validate_twilio_sid, only: [:twilio_callback]

  def home
    render text: 'I am Pat Maddox'
  end

  def twilio_callback
    render xml: Contact.lookup(params['From']).
      forward_call(voicemails_url).response
  end
end
