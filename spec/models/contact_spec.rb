require 'spec_helper'

describe Contact do
  describe ".whitelisted?(phone)" do
    it "is true when the phone number is whitelisted" do
      Contact.create! phone_number: "123", whitelist: true, name: 'Pat'
      expect(Contact.whitelisted?("123")).to be_true
    end

    it "is false when the phone number is not whitelisted" do
      Contact.create! phone_number: "123", whitelist: false, name: 'Pat'
      expect(Contact.whitelisted?("123")).to be_false
    end

    it "is false when no such phone number is known" do
      expect(Contact.whitelisted?("123")).to be_false
    end
  end

  describe "validations" do
    it "rejects a contact that is whitelisted and blacklisted" do
      contact = Contact.new whitelist: true, blacklist: true, name: 'Pat'
      contact.should_not be_valid
      expect(contact).to have(1).error_on(:whitelist)
      expect(contact).to have(1).error_on(:blacklist)
    end
  end

  describe "whitelist" do
    let(:contact) { Contact.new }

    it "sets whitelist? to true" do
      contact.whitelist
      contact.should be_whitelist
    end

    it "sets blacklist? to false" do
      contact.blacklist = true
      contact.whitelist
      contact.should_not be_blacklist
    end
  end

  describe "blacklist" do
    let(:contact) { Contact.new }

    it "sets blacklist? to true" do
      contact.blacklist
      contact.should be_blacklist
    end

    it "sets whitelist? to false" do
      contact.whitelist = true
      contact.blacklist
      contact.should_not be_whitelist
    end
  end
end
