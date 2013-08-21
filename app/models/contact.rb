class Contact < ActiveRecord::Base
  validates :name, :presence => true

  scope :whitelisted, -> { where(state: 'whitelisted') }
  scope :blacklisted, -> { where(state: 'blacklisted') }

  def self.lookup(phone_number)
    where(phone_number: phone_number).first || new(phone_number: phone_number)
  end

  alias_method :unknown?, :new_record?
  def known?
    !unknown?
  end

  def whitelist
    self.state = "whitelisted"
  end

  def whitelisted?
    state == "whitelisted"
  end

  def blacklist
    self.state = "blacklisted"
  end

  def blacklisted?
    self.state == "blacklisted"
  end

  def forward_call(voicemails_url)
    if unknown?
      Twilio::Verb.new do |v|
        v.say "Leave a message after the tone. You have 30 seconds."
        v.record maxLength: 30, action: voicemails_url
      end
    elsif whitelisted?
      Twilio::Verb.dial(ENV['MY_PHONE_NUMBER'])
    elsif blacklisted?
      Twilio::Verb.new do |v|
        v.pause 3
        v.say "Thank you for your interest in hiring Pat Maddox. Please wait while I connect you to his agent."
        v.dial Contact.find(2).phone_number, :timeLimit => 10
        v.say "Self-destruct sequence initiated"
        3.downto(1) {|i| v.say i.to_s; v.pause 1 }
        v.hangup
      end
    end
  end
end
