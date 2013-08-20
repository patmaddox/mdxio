class VoicemailsController < ApplicationController
  protect_from_forgery :except => [:post]

  def post
    Voicemail.create! phone_number: params['From'], url: params['RecordingUrl']
    render xml: Twilio::Verb.say('Goodbye')
  end

  def index
    @voicemails = Voicemail.order(created_at: :desc).all
  end
end
