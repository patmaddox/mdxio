class MainController < ApplicationController
  protect_from_forgery except: [:twilio_callback]
  before_filter :validate_twilio_sid, only: [:twilio_callback]

  def home
    render text: 'I am Pat Maddox'
  end

  def twilio_callback
    contact = Contact.lookup params['From']
    if contact.unknown?
      verb = Twilio::Verb.new do |v|
        v.say "Leave a message after the tone. You have 30 seconds."
        v.record maxLength: 30, action: voicemails_url
      end
      render xml: verb.response
    elsif contact.whitelisted?
      render xml: Twilio::Verb.dial(ENV['MY_PHONE_NUMBER'])
    elsif contact.blacklisted?
      verb = Twilio::Verb.new do |v|
        v.pause 3
        v.say "Thank you for your interest in hiring Pat Maddox. Please wait while I connect you to his agent."
        v.dial Contact.find(2).phone_number, :timeLimit => 10
        v.say "Self-destruct sequence initiated"
        3.downto(1) {|i| v.say i.to_s; v.pause 1 }
        v.hangup
      end
      render xml: verb.response
    end
  end
end
