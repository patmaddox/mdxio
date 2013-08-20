class Contact < ActiveRecord::Base
  validates :name, :presence => true
  scope :whitelisted, where(:whitelist => true)
  scope :blacklisted, where(:blacklist => true)
end
