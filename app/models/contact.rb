class Contact < ActiveRecord::Base
  validates :name, :presence => true
  scope :whitelisted, -> { where(:whitelist => true) }
  scope :blacklisted, -> { where(:blacklist => true) }

  def self.whitelisted?(phone_number)
    whitelisted.where(phone_number: phone_number).exists?
  end
end
