require 'rails_helper'

module Tang
  RSpec.describe Coupon, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "has a valid factory" do
      expect(FactoryGirl.create(:coupon)).to be_valid
    end

    it "is invalid without a stripe_id" do
      expect(FactoryGirl.build(:coupon, stripe_id: nil)).to be_invalid
    end

    it "is invalid without a duration" do
      expect(FactoryGirl.build(:coupon, duration: nil)).to be_invalid
    end

    it "is invalid without a currency if amount off" do
      expect(FactoryGirl.build(:coupon, amount_off: 500, currency: nil)).to be_invalid
    end

    it "is invalid without a duration in months if repeating" do
      expect(FactoryGirl.build(:coupon, duration: 'repeating', duration_in_months: nil)).to be_invalid
    end

    it "is invalid without an amount off or percent off" do
      expect(FactoryGirl.build(:coupon, amount_off: nil, percent_off: nil)).to be_invalid
    end
  end
end
