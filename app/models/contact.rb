class Contact < ActiveRecord::Base
  validates :name, :presence => true
  validate :whitelist_xor_blacklist
  scope :whitelisted, -> { where(:whitelist => true) }
  scope :blacklisted, -> { where(:blacklist => true) }

  def self.whitelisted?(phone_number)
    whitelisted.where(phone_number: phone_number).exists?
  end

  def whitelist
    self.blacklist = false
    self.whitelist = true
  end

  def blacklist
    self.whitelist = false
    self.blacklist = true
  end

  private
  def whitelist_xor_blacklist
    if whitelist? && blacklist?
      errors.add(:whitelist, 'cannot be true along with blacklist')
      errors.add(:blacklist, 'cannot be true along with whitelist')
    end
  end
end
