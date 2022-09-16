require 'rails_helper'

module Tang
  describe PayInvoice do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'creates a new charge for an invoice' do
      plan = FactoryBot.build(:plan)
      stripe_product = stripe_helper.create_product
      stripe_plan = stripe_helper.create_plan(id: plan.stripe_id, amount: plan.amount, product: stripe_product.id)

      customer = FactoryBot.create(:customer)

      stripe_customer = Stripe::Customer.create({
                                                  email: customer.email,
                                                  source: stripe_helper.generate_card_token,
                                                  plan: plan.stripe_id
                                                })

      customer.stripe_id = stripe_customer.id
      customer.save

      subscription = FactoryBot.create(:subscription, plan: plan, customer: customer,
                                                      stripe_id: stripe_customer.subscriptions.first.id)

      invoice = FactoryBot.create(:invoice, subscription: subscription, customer: customer)
      stripe_charge = Stripe::Charge.create(amount: 100, currency: 'usd', customer: stripe_customer.id)

      event = StripeMock.mock_webhook_event('invoice.payment_succeeded', id: invoice.stripe_id,
                                                                         subscription: subscription.stripe_id, charge: stripe_charge.id)
      stripe_invoice = event.data.object

      count = Charge.count

      charge = PayInvoice.call(stripe_invoice)

      expect(Charge.count).to eq count + 1

      expect(charge.invoice.id).to eq invoice.id

      customer.reload
      invoice.reload
      subscription.reload

      expected_end_time = subscription.period_end
      difference = customer.active_until - expected_end_time
      expect(difference.abs).to be <= 1.day # difference of one day (allow for delay)
    end
  end
end
