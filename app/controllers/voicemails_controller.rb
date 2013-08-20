class VoicemailsController < ApplicationController
  protect_from_forgery except: [:create]
  before_filter :validate_twilio_sid, only: [:create]

  def create
    vm = Voicemail.create! phone_number: params['From'], url: params['RecordingUrl']
    Twilio::Sms.message(
      ENV['TWILIO_PHONE_NUMBER'],
      ENV['MY_PHONE_NUMBER'],
      "New voicemail received from #{params['From']}. Visit #{voicemail_url(vm)} to listen."
    )
    render xml: Twilio::Verb.say('Goodbye')
  end

  def index
    @voicemails = Voicemail.order(created_at: :desc).all
  end
end
