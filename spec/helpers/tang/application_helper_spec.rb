require 'rails_helper'

RSpec.describe Tang::ApplicationHelper, type: :helper do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe '#created_datetime' do
    it 'returns a formatted date' do
      created_at = Time.new(2015, 8, 1, 14, 35, 0)
      expect(helper.created_datetime(created_at)).to eq('2015/08/01 14:35')
    end
  end

  describe '#plan_cost' do
    it 'returns a formatted cost' do
      plan = FactoryBot.build(:plan)
      expect(helper.plan_cost(plan)).to eq('$20.00/month')
    end
  end

  describe '#customer_plan_cost' do
    it 'returns a formatted cost' do
      subscription = FactoryBot.build(:subscription)
      expect(helper.customer_plan_cost(subscription.customer, subscription.plan)).to eq('$20.00/month')
    end

    it 'returns a percent off discounted formatted cost' do
      subscription = FactoryBot.build(:subscription)
      coupon = FactoryBot.build(:coupon)
      subscription.customer.coupon = coupon
      expect(helper.customer_plan_cost(subscription.customer, subscription.plan)).to eq('$10.00/month')
    end

    it 'returns an amount off discounted formatted cost' do
      subscription = FactoryBot.build(:subscription)
      coupon = FactoryBot.build(:amount_off_coupon)
      subscription.customer.coupon = coupon
      expect(helper.customer_plan_cost(subscription.customer, subscription.plan)).to eq('$15.00/month')
    end
  end

  describe '#current_customer' do
    it 'returns the current customer' do
      customer = FactoryBot.build(:customer)
      assign(:current_customer, customer)
      expect(helper.current_customer).to eq(customer)
    end
  end

  describe '#coupon_off' do
    it 'returns a formatted percent off discount' do
      coupon = FactoryBot.build(:coupon)
      expect(helper.coupon_off(coupon)).to eq('50% off')
    end

    it 'returns a formatted amount off discount' do
      coupon = FactoryBot.build(:amount_off_coupon)
      expect(helper.coupon_off(coupon)).to eq('$5.00 off')
    end
  end
end
