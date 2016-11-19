require 'rails_helper'

module Tang
  RSpec.describe Invoice, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "has a valid factory" do
      expect(FactoryGirl.create(:invoice)).to be_valid
    end

    it "is invalid without a subscription" do
      expect(FactoryGirl.build(:invoice, subscription: nil)).to be_invalid
    end

    it "is invalid without a customer" do
      expect(FactoryGirl.build(:invoice, customer: nil)).to be_invalid
    end

    it "is invalid without a stripe id" do
      expect(FactoryGirl.build(:invoice, stripe_id: nil)).to be_invalid
    end
  end
end
