class AddStateToContacts < ActiveRecord::Migration
  class Contact < ActiveRecord::Base; end

  def up
    add_column :contacts, :state, :string
    Contact.reset_column_information
    Contact.all.each do |contact|
      contact.state = "whitelisted" if contact.whitelisted?
      contact.state = "blacklisted" if contact.blacklisted?
      contact.save if contact.changed?
    end
    remove_column :contacts, :whitelisted
    remove_column :contacts, :blacklisted
  end

  def down
    add_column :contacts, :whitelisted, :null => false, :default => false
    add_column :contacts, :blacklisted, :null => false, :default => false
    Contact.reset_column_information
    Contact.all.each do |contact|
      contact.whitelisted = true if contact.state == "whitelisted"
      contact.blacklisted = true if contact.state == "blacklisted"
      contact.save if contact.changed?
    end
    remove_column :contacts, :state
  end
end
