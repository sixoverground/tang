require 'rails_helper'

module Tang
  RSpec.describe Customer  do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }
    
    it "responds to admin?" do
      customer = FactoryGirl.create(:customer)
      admin = FactoryGirl.create(:admin)
      expect(customer.admin?).to be_falsey
      expect(admin.admin?).to be_truthy
    end

    it "generates a password" do
      customer = FactoryGirl.build(:customer, password: nil)
      customer.generate_password
      expect(customer.password).to_not be_nil
    end

    it "is subscribed to a plan" do
      subscription = FactoryGirl.create(:subscription)
      stripe_id = subscription.plan.stripe_id
      expect(subscription.customer.subscribed_to?(stripe_id)).to be_truthy
    end

    it "is not subscribed to a plan" do
      subscription = FactoryGirl.create(:subscription)
      plan = FactoryGirl.create(:premium_plan)
      stripe_id = plan.stripe_id
      expect(subscription.customer.subscribed_to?(stripe_id)).to be_falsey
    end
  end
end