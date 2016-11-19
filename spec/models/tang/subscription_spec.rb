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

    it "has a period start" do
      expect(FactoryGirl.create(:subscription).period_start).to be <= Time.now
    end

    it "matches its invoice period start" do
      invoice = FactoryGirl.create(:invoice)
      expect(invoice.subscription.period_start).to eq(invoice.period_start)
    end

    it "has a period end" do
      expect(FactoryGirl.create(:subscription).period_end).to be >= Time.now
    end

    it "has a stripe trial end" do
      trial_end = Time.now + 30.days
      expect(FactoryGirl.create(:subscription, trial_end: trial_end).stripe_trial_end).to eq(trial_end.to_i)
    end

    it "can have a stripe trial end of now" do
      subscription = FactoryGirl.create(:subscription)
      subscription.end_trial_now = true
      expect(subscription.stripe_trial_end).to eq('now')
    end
  end
end
