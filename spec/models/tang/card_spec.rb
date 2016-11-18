require 'rails_helper'

module Tang
  RSpec.describe Card, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "has a valid factory" do
      expect(FactoryGirl.create(:card)).to be_valid
    end

    it "is invalid without a customer" do
      expect(FactoryGirl.build(:card, customer: nil)).to be_invalid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:card, name: nil)).to be_invalid
    end

    it "is invalid without last4" do
      expect(FactoryGirl.build(:card, last4: nil)).to be_invalid
    end

    it "is invalid without an expiration month" do
      expect(FactoryGirl.build(:card, exp_month: nil)).to be_invalid
    end

    it "is invalid without an expiration year" do
      expect(FactoryGirl.build(:card, exp_year: nil)).to be_invalid
    end

    it "is invalid without an address zip" do
      expect(FactoryGirl.build(:card, address_zip: nil)).to be_invalid
    end

    it "can be updated from stripe" do
      card = FactoryGirl.create(:card)

      stripe_customer = Stripe::Customer.create(id: 'test_customer_sub')
      card_token = stripe_helper.generate_card_token(last4: "1123", exp_month: 11, exp_year: 2017, address_zip: '90210')
      stripe_card = stripe_customer.sources.create(source: card_token)

      card.update_from_stripe(stripe_card)
      expect(card.last4).to eq(stripe_card.last4)
    end

  end
end
