require 'rails_helper'

describe 'Stripe Events' do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe 'charge.dispute.created' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('charge.dispute.created')
      dispute_object = event.data.object

      post '/stripe_event', id: event.id
      expect(response.code).to eq('200')

      expect(dispute_object.id).to_not be_nil
      expect(dispute_object.charge).to_not be_nil
    end
  end

  describe 'charge.dispute.updated' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('charge.dispute.updated')
      dispute_object = event.data.object

      post '/stripe_event', id: event.id
      expect(response.code).to eq('200')

      expect(dispute_object.id).to_not be_nil
      expect(dispute_object.charge).to_not be_nil
    end
  end

  describe 'charge.dispute.closed' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('charge.dispute.closed')
      dispute_object = event.data.object

      post '/stripe_event', id: event.id
      expect(response.code).to eq('200')

      expect(dispute_object.id).to_not be_nil
      expect(dispute_object.charge).to_not be_nil
    end
  end

  describe 'invoice.created' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('invoice.created')
      invoice_object = event.data.object

      post '/stripe_event', id: event.id
      expect(response.code).to eq('200')

      expect(invoice_object.id).to_not be_nil
    end
  end

  describe 'invoice.payment_succeeded' do
    it 'mocks a stripe webhook' do
      stripe_plan = stripe_helper.create_plan
      customer = FactoryGirl.create(:customer)
      stripe_customer = Stripe::Customer.create(
        source: stripe_helper.generate_card_token,
        plan: stripe_plan.id,
        email: customer.email
      )
      subscription = FactoryGirl.create(:subscription, stripe_id: stripe_customer.subscriptions.first.id)
      stripe_charge = Stripe::Charge.create(
        amount: stripe_plan.amount, 
        currency: stripe_plan.currency,
        customer: stripe_customer.id
      )
      invoice = FactoryGirl.create(:invoice, subscription: subscription)
      
      event = StripeMock.mock_webhook_event('invoice.payment_succeeded', 
        subscription: subscription.stripe_id,
        charge: stripe_charge.id,
        id: invoice.stripe_id
      )
      invoice_object = event.data.object

      post '/stripe_event', id: event.id
      expect(response.code).to eq('200')

      expect(invoice_object.id).to_not be_nil
      expect(invoice_object.charge).to_not be_nil
      expect(invoice_object.subscription).to_not be_nil
    end
  end

  describe 'invoice.payment_failed' do
    it 'mocks a stripe webhook' do
      stripe_plan = stripe_helper.create_plan
      customer = FactoryGirl.create(:customer)
      stripe_customer = Stripe::Customer.create(
        source: stripe_helper.generate_card_token,
        plan: stripe_plan.id,
        email: customer.email
      )
      subscription = FactoryGirl.create(:subscription, stripe_id: stripe_customer.subscriptions.first.id)
      stripe_charge = Stripe::Charge.create(
        amount: stripe_plan.amount, 
        currency: stripe_plan.currency,
        customer: stripe_customer.id
      )
      invoice = FactoryGirl.create(:invoice, subscription: subscription)

      event = StripeMock.mock_webhook_event('invoice.payment_failed',
        subscription: subscription.stripe_id,
        charge: stripe_charge.id,
        id: invoice.stripe_id
      )
      invoice_object = event.data.object

      post '/stripe_event', id: event.id
      expect(response.code).to eq('200')

      expect(invoice_object.id).to_not be_nil
      expect(invoice_object.charge).to_not be_nil
      expect(invoice_object.subscription).to_not be_nil
    end
  end
end