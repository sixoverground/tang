require 'rails_helper'

module Tang
  RSpec.describe Plan, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "has a valid factory" do
      expect(FactoryGirl.create(:plan)).to be_valid
    end

    it "is invalid without a stripe id" do
      expect(FactoryGirl.build(:plan, stripe_id: nil)).to be_invalid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:plan, name: nil)).to be_invalid
    end

    it "is invalid without an amount" do
      expect(FactoryGirl.build(:plan, amount: nil)).to be_invalid
    end

    it "is invalid without a currency" do
      expect(FactoryGirl.build(:plan, currency: nil)).to be_invalid
    end

    it "is invalid without an interval" do
      expect(FactoryGirl.build(:plan, interval: nil)).to be_invalid
    end
  end
end
