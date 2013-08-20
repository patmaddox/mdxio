class MainController < ApplicationController
  protect_from_forgery :except => [:twilio_callback, :voicemail_callback]

  def home
    render text: 'I am Pat Maddox'
  end

  def twilio_callback
    if Contact.whitelisted?(params['From'])
      render xml: Twilio::Verb.dial(ENV['MY_PHONE_NUMBER'])
    else
      verb = Twilio::Verb.new do |v|
        v.say "Leave a message. You have 30 seconds."
        v.record maxLength: 30, action: voicemail_callback_url
      end
      render xml: verb.response
#      render xml: Twilio::Verb.reject
    end
  end

  def voicemail_callback
    Voicemail.create! phone_number: params['From'], url: params['RecordingUrl']
    render xml: Twilio::Verb.say('Goodbye')
  end
end
