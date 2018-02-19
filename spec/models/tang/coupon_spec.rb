require 'rails_helper'

module Tang
  RSpec.describe Coupon, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "has a valid factory" do
      expect(FactoryBot.create(:coupon)).to be_valid
    end

    it "is invalid without a stripe_id" do
      expect(FactoryBot.build(:coupon, stripe_id: nil)).to be_invalid
    end

    it "is invalid without a duration" do
      expect(FactoryBot.build(:coupon, duration: nil)).to be_invalid
    end

    it "is invalid without a currency if amount off" do
      expect(FactoryBot.build(:coupon, amount_off: 500, currency: nil)).to be_invalid
    end

    it "is invalid without a duration in months if repeating" do
      expect(FactoryBot.build(:coupon, duration: 'repeating', duration_in_months: nil)).to be_invalid
    end

    it "is invalid without an amount off or percent off" do
      expect(FactoryBot.build(:coupon, amount_off: nil, percent_off: nil)).to be_invalid
    end

    it "is invalid with a reedem by date in the past" do
      expect(FactoryBot.build(:coupon, redeem_by: Time.now - 30.days)).to be_invalid
      expect(FactoryBot.build(:coupon, redeem_by: Time.now - 30.days).coupon_valid?).to be_falsey
    end

    it "is valid with a reedem by date in the future" do
      expect(FactoryBot.build(:coupon, redeem_by: Time.now + 30.days).coupon_valid?).to be_truthy
    end

    it "formats a repeating duration" do
      expect(FactoryBot.build(:coupon, duration: 'repeating', duration_in_months: 2).formatted_duration).to eq("for 2 months")
    end

    it "formats a non-repeating duration" do
      expect(FactoryBot.build(:coupon, duration: 'once').formatted_duration).to eq("once")
    end

    it "lists active redemptions" do
      coupon = FactoryBot.create(:coupon)
      subscription = FactoryBot.create(:subscription)
      customer = subscription.customer
      customer.coupon = coupon
      customer.save
      expect(coupon.active_redemptions).to include(customer)
    end

    it "answers to repeating?" do
      expect(FactoryBot.build(:coupon, duration: 'repeating').repeating?).to be_truthy
    end
  end
end
