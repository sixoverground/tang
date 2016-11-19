require 'rails_helper'

module Tang
  RSpec.describe Subscription, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "has a valid factory" do
      expect(FactoryGirl.create(:subscription)).to be_valid
    end

    it "is invalid without a stripe_id" do
      expect(FactoryGirl.build(:subscription, stripe_id: nil)).to be_invalid
    end

    it "is invalid without a customer" do
      expect(FactoryGirl.build(:subscription, customer: nil)).to be_invalid
    end

    it "is invalid without a plan" do
      expect(FactoryGirl.build(:subscription, plan: nil)).to be_invalid
    end
  end
end
