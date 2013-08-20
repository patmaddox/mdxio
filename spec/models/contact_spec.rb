require 'spec_helper'

describe Contact do
  describe ".whitelisted?(phone)" do
    it "is true when the phone number is whitelisted" do
      Contact.create! phone_number: "123", whitelisted: true, name: 'Pat'
      expect(Contact.whitelisted?("123")).to be_true
    end

    it "is false when the phone number is not whitelisted" do
      Contact.create! phone_number: "123", whitelisted: false, name: 'Pat'
      expect(Contact.whitelisted?("123")).to be_false
    end

    it "is false when no such phone number is known" do
      expect(Contact.whitelisted?("123")).to be_false
    end
  end

  describe "validations" do
    it "rejects a contact that is whitelisted and blacklisted" do
      contact = Contact.new whitelisted: true, blacklisted: true, name: 'Pat'
      contact.should_not be_valid
      expect(contact).to have(1).error_on(:whitelisted)
      expect(contact).to have(1).error_on(:blacklisted)
    end
  end

  describe "whitelist" do
    let(:contact) { Contact.new }

    it "sets whitelisted? to true" do
      contact.whitelist
      contact.should be_whitelisted
    end

    it "sets blacklisted? to false" do
      contact.blacklisted = true
      contact.whitelist
      contact.should_not be_blacklisted
    end
  end

  describe "blacklist" do
    let(:contact) { Contact.new }

    it "sets blacklisted? to true" do
      contact.blacklist
      contact.should be_blacklisted
    end

    it "sets whitelisted? to false" do
      contact.whitelisted = true
      contact.blacklist
      contact.should_not be_whitelisted
    end
  end
end
