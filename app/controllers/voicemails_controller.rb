class VoicemailsController < ApplicationController
  protect_from_forgery :except => [:post]

  def post
    vm = Voicemail.create! phone_number: params['From'], url: params['RecordingUrl']
    Twilio::Sms.message(
      ENV['MY_PHONE_NUMBER'],
      ENV['MY_PHONE_NUMBER'],
      "New voicemail received from #{params['From']}. Visit #{voicemail_url(vm)} to listen."
    )
    render xml: Twilio::Verb.say('Goodbye')
  end

  def index
    @voicemails = Voicemail.order(created_at: :desc).all
  end
end
