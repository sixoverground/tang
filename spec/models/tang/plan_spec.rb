require 'rails_helper'

module Tang
  RSpec.describe Plan, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'has a valid factory' do
      expect(FactoryBot.create(:plan)).to be_valid
    end

    it 'is invalid without a stripe id' do
      expect(FactoryBot.build(:plan, stripe_id: nil)).to be_invalid
    end

    it 'is invalid without a name' do
      expect(FactoryBot.build(:plan, name: nil)).to be_invalid
    end

    it 'is invalid without an amount' do
      expect(FactoryBot.build(:plan, amount: nil)).to be_invalid
    end

    it 'is invalid without a currency' do
      expect(FactoryBot.build(:plan, currency: nil)).to be_invalid
    end

    it 'is invalid without an interval' do
      expect(FactoryBot.build(:plan, interval: nil)).to be_invalid
    end

    it 'calculates period days for a day interval' do
      now = Time.now
      expect(FactoryBot.build(:plan, interval: 'day').period_days_from(now)).to eq(now + 1.day)
    end

    it 'calculates period days for a week interval' do
      now = Time.now
      expect(FactoryBot.build(:plan, interval: 'week').period_days_from(now)).to eq(now + 1.week)
    end

    it 'calculates period days for a month interval' do
      now = Time.now
      expect(FactoryBot.build(:plan, interval: 'month').period_days_from(now)).to eq(now + 1.month)
    end

    it 'calculates period days for a year interval' do
      now = Time.now
      expect(FactoryBot.build(:plan, interval: 'year').period_days_from(now)).to eq(now + 1.year)
    end
  end
end
