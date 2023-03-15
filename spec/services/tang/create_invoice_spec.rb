require 'rails_helper'

module Tang
  describe CreateInvoice do
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'creates a new invoice for a subscription' do
      subscription = FactoryBot.create(:subscription)
      event = StripeMock.mock_webhook_event(
        'invoice.created',
        customer: subscription.customer.stripe_id,
        subscription: subscription.stripe_id
      )

      count = Invoice.count

      invoice = CreateInvoice.call(event)

      expect(Invoice.count).to eq count + 1

      expect(invoice.subscription.id).to eq subscription.id
    end
  end
end
