require 'rails_helper'

module Tang
  RSpec.describe Card, type: :model do
    pending "add some examples to (or delete) #{__FILE__}"

    it "has a valid factory" do
      expect(FactoryGirl.create(:card)).to be_valid
    end

    it "is invalid without a customer" do
      expect(FactoryGirl.build(:card, customer: nil)).to be_invalid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:card, name: nil)).to be_invalid
    end

    it "is invalid without last4" do
      expect(FactoryGirl.build(:card, last4: nil)).to be_invalid
    end

    it "is invalid without an expiration month" do
      expect(FactoryGirl.build(:card, exp_month: nil)).to be_invalid
    end

    it "is invalid without an expiration year" do
      expect(FactoryGirl.build(:card, exp_year: nil)).to be_invalid
    end

    it "is invalid without an address zip" do
      expect(FactoryGirl.build(:card, address_zip: nil)).to be_invalid
    end


  end
end
