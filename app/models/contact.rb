class Contact < ActiveRecord::Base
  validates :name, :presence => true
  validate :whitelist_xor_blacklist
  scope :whitelisted, -> { where(:whitelisted => true) }
  scope :blacklisted, -> { where(:blacklisted => true) }

  def self.whitelisted?(phone_number)
    whitelisted.where(phone_number: phone_number).exists?
  end

  def whitelist
    self.blacklisted = false
    self.whitelisted = true
  end

  def blacklist
    self.whitelisted = false
    self.blacklisted = true
  end

  private
  def whitelist_xor_blacklist
    if whitelisted? && blacklisted?
      errors.add(:whitelisted, 'cannot be true along with blacklisted')
      errors.add(:blacklisted, 'cannot be true along with whitelisted')
    end
  end
end
