require "rails_helper"

RSpec.describe Tang::ApplicationHelper, :type => :helper do
  describe "#created_datetime" do
    it "returns a formatted date" do
      created_at = Time.new(2015, 8, 1, 14, 35, 0)
      expect(helper.created_datetime(created_at)).to eq('2015/08/01 14:35')
    end
  end

  describe "#plan_cost" do
    it "returns a formatted cost" do
      plan = FactoryGirl.build(:plan)
      expect(helper.plan_cost(plan)).to eq('$20.00/month')
    end
  end

  describe "#customer_plan_cost" do
    it "returns a formatted cost" do
      subscription = FactoryGirl.build(:subscription)
      expect(helper.customer_plan_cost(subscription.customer, subscription.plan)).to eq('$20.00/month')
    end

    it "returns a percent off discounted formatted cost" do
      subscription = FactoryGirl.build(:subscription)
      coupon = FactoryGirl.build(:coupon)
      subscription.customer.coupon = coupon
      expect(helper.customer_plan_cost(subscription.customer, subscription.plan)).to eq('$10.00/month')
    end

    it "returns an amount off discounted formatted cost" do
      subscription = FactoryGirl.build(:subscription)
      coupon = FactoryGirl.build(:amount_off_coupon)
      subscription.customer.coupon = coupon
      expect(helper.customer_plan_cost(subscription.customer, subscription.plan)).to eq('$15.00/month')
    end
  end

  describe "#current_customer" do
    it "returns the current customer" do
      customer = FactoryGirl.build(:customer)
      assign(:current_customer, customer)
      expect(helper.current_customer).to eq(customer)
    end
  end

  describe "#coupon_off" do
    it "returns a formatted percent off discount" do
      coupon = FactoryGirl.build(:coupon)
      expect(helper.coupon_off(coupon)).to eq("50\% off")
    end

    it "returns a formatted amount off discount" do
      coupon = FactoryGirl.build(:amount_off_coupon)
      expect(helper.coupon_off(coupon)).to eq('$5.00 off')
    end
  end

  describe "#discount" do
    it "returns a formatted percent off discount" do
      amount = 2000
      coupon = FactoryGirl.build(:coupon)
      expect(helper.discount(amount, coupon)).to eq('-$10.00')
    end

    it "returns a formatted amount off discount" do
      amount = 2000
      coupon = FactoryGirl.build(:amount_off_coupon)
      expect(helper.discount(amount, coupon)).to eq('-$5.00')
    end
  end
end