require 'rails_helper'

module Tang
  RSpec.describe Charge, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'has a valid factory' do
      expect(FactoryBot.create(:charge)).to be_valid
    end

    it 'is invalid without an invoice' do
      expect(FactoryBot.build(:charge, invoice: nil)).to be_invalid
    end

    it 'is invalid without a stripe id' do
      expect(FactoryBot.build(:charge, stripe_id: nil)).to be_invalid
    end

    it 'is invalid without an amount greater than 50' do
      expect(FactoryBot.build(:charge, amount: 0)).to be_invalid
    end

    it 'is invalid without a currency' do
      expect(FactoryBot.build(:charge, currency: nil)).to be_invalid
    end

    it 'is invalid with a long statement descriptor' do
      expect(FactoryBot.build(:charge, statement_descriptor: '123456789012345678901234567890')).to be_invalid
    end

    it 'can be searched by stripe id' do
      charge = FactoryBot.create(:charge)
      expect(Charge.search(charge.stripe_id)).to include(charge)
    end

    it 'can be searched by customer stripe id' do
      stripe_customer = Stripe::Customer.create(id: 'test_customer_sub')
      customer = FactoryBot.create(:customer, stripe_id: stripe_customer.id)
      invoice = FactoryBot.create(:invoice, customer: customer)
      charge = FactoryBot.create(:charge, invoice: invoice)
      expect(Charge.search(customer.stripe_id)).to include(charge)
    end

    it 'can set the card source from stripe' do
      stripe_charge = Stripe::Charge.create(amount: 1, currency: 'usd', source: stripe_helper.generate_card_token)
      invoice = FactoryBot.create(:invoice)
      charge = Charge.from_stripe(stripe_charge, invoice)
      expect(charge.card_stripe_id).to eq(stripe_charge.source.id)
    end
  end
end
