require 'rails_helper'

module Tang
  RSpec.describe Customer  do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }
    
    it "responds to admin?" do
      customer = FactoryBot.create(:customer)
      admin = FactoryBot.create(:admin)
      expect(customer.admin?).to be_falsey
      expect(admin.admin?).to be_truthy
    end

    it "generates a password" do
      customer = FactoryBot.build(:customer, password: nil)
      customer.generate_password
      expect(customer.password).to_not be_nil
    end

    it "is subscribed to a plan" do
      subscription = FactoryBot.create(:subscription)
      stripe_id = subscription.plan.stripe_id
      expect(subscription.customer.subscribed_to?(stripe_id)).to be_truthy
    end

    it "is not subscribed to a plan" do
      subscription = FactoryBot.create(:subscription)
      plan = FactoryBot.create(:premium_plan)
      stripe_id = plan.stripe_id
      expect(subscription.customer.subscribed_to?(stripe_id)).to be_falsey
    end
  end
end