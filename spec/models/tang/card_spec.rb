require 'rails_helper'

module Tang
  RSpec.describe Card, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it "has a valid factory" do
      expect(FactoryBot.create(:card)).to be_valid
    end

    it "is invalid without a customer" do
      expect(FactoryBot.build(:card, customer: nil)).to be_invalid
    end

    it "is invalid without a name" do
      expect(FactoryBot.build(:card, name: nil)).to be_invalid
    end

    it "is invalid without last4" do
      expect(FactoryBot.build(:card, last4: nil)).to be_invalid
    end

    it "is invalid without an expiration month" do
      expect(FactoryBot.build(:card, exp_month: nil)).to be_invalid
    end

    it "is invalid without an expiration year" do
      expect(FactoryBot.build(:card, exp_year: nil)).to be_invalid
    end

    it "is invalid without an address zip" do
      expect(FactoryBot.build(:card, address_zip: nil)).to be_invalid
    end

    it "can be updated from stripe" do
      card = FactoryBot.create(:card)

      stripe_customer = Stripe::Customer.create(id: 'test_customer_sub')
      card_token = stripe_helper.generate_card_token(last4: "1123", exp_month: 11, exp_year: 2017, address_zip: '90210')
      stripe_card = stripe_customer.sources.create(source: card_token)

      card.update_from_stripe(stripe_card)
      expect(card.last4).to eq(stripe_card.last4)
    end

  end
end
