require 'rails_helper'

module Tang
  RSpec.describe Invoice, type: :model do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'has a valid factory' do
      expect(FactoryBot.create(:invoice)).to be_valid
    end

    it 'is invalid without a customer' do
      expect(FactoryBot.build(:invoice, customer: nil)).to be_invalid
    end

    it 'is invalid without a stripe id' do
      expect(FactoryBot.build(:invoice, stripe_id: nil)).to be_invalid
    end

    it 'is paid if a charge is present' do
      charge = FactoryBot.create(:charge)
      expect(charge.invoice.status).to eq('paid')
    end

    it 'is unpaid if no charge is present' do
      invoice = FactoryBot.create(:invoice)
      expect(invoice.status).to eq('unpaid')
    end
  end
end
