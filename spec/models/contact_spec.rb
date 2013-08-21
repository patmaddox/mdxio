require 'spec_helper'

describe Contact do
  describe ".lookup(phone_number)" do
    it "fetches a matching record" do
      contact = Contact.create! phone_number: "123", name: 'Pat'
      expect(Contact.lookup("123")).to eq(contact)
    end

    it "returns a new record if none match" do
      expect(Contact.lookup("456")).to be_new_record
    end
  end

  describe ".whitelisted" do
    it "returns whitelisted contacts" do
      contact = Contact.create name: 'Pat', state: 'whitelisted'
      expect(Contact.whitelisted).to include(contact)
    end
  end

  describe ".blacklisted" do
    it "returns blacklisted contacts" do
      contact = Contact.create name: 'Pat', state: 'blacklisted'
      expect(Contact.blacklisted).to include(contact)
    end
  end

  describe "#unknown?" do
    it "is true for a new record" do
      expect(Contact.new).to be_unknown
    end

    it "is false for a saved record" do
      expect(Contact.create!(name: 'Pat')).to_not be_unknown
    end
  end

  describe "#known?" do
    it "is true for a saved record" do
      expect(Contact.create!(name: 'Pat')).to be_known
    end

    it "is false for a new record" do
      expect(Contact.new).to_not be_known
    end
  end

  describe "whitelist" do
    let(:contact) { Contact.new }

    it "sets whitelisted? to true" do
      contact.whitelist
      contact.should be_whitelisted
    end
  end

  describe "blacklist" do
    let(:contact) { Contact.new }

    it "sets blacklisted? to true" do
      contact.blacklist
      contact.should be_blacklisted
    end
  end
end
