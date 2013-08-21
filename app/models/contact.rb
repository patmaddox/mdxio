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
end
