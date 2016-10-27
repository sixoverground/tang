require 'rails_helper'

module Tang
  describe PayInvoice do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }
  
    it "creates a new charge for an invoice" do
      plan = FactoryGirl.create(:plan)

      customer = FactoryGirl.create(:customer)

      stripe_customer = Stripe::Customer.create({
        email: customer.email,
        source: stripe_helper.generate_card_token,
        plan: plan.stripe_id
      })

      customer.stripe_id = stripe_customer.id
      customer.save

      subscription = FactoryGirl.create(:subscription, plan: plan, customer: customer, stripe_id: stripe_customer.subscriptions.first.id)

      invoice = FactoryGirl.create(:invoice, subscription: subscription)

      stripe_charge = Stripe::Charge.create(amount: 100, currency: 'usd')

      event = StripeMock.mock_webhook_event('invoice.payment_succeeded', id: invoice.stripe_id, subscription: subscription.stripe_id, charge: stripe_charge.id)
      
      count = Charge.count
      
      charge = PayInvoice.call(event)

      expect(Charge.count).to eq count + 1

      expect(charge.invoice.id).to eq invoice.id

      customer.reload
      expect(customer.active_until).to eq Time.now.utc.change(usec: 0) + 1.month
    end
  end
end