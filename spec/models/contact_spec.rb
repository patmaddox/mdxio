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
end
