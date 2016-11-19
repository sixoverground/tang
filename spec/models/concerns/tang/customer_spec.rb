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

  end
end