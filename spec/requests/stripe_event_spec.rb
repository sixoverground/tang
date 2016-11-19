require 'rails_helper'

describe 'Stripe Events' do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe 'charge.dispute.created' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('charge.dispute.created')
      dispute_object = event.data.object
      expect(dispute_object.id).to_not be_nil
      expect(dispute_object.charge).to_not be_nil
    end
  end

  describe 'charge.dispute.updated' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('charge.dispute.updated')
      dispute_object = event.data.object
      expect(dispute_object.id).to_not be_nil
      expect(dispute_object.charge).to_not be_nil
    end
  end

  describe 'charge.dispute.closed' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('charge.dispute.closed')
      dispute_object = event.data.object
      expect(dispute_object.id).to_not be_nil
      expect(dispute_object.charge).to_not be_nil
    end
  end

  describe 'invoice.created' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('invoice.created')
      invoice_object = event.data.object
      expect(invoice_object.id).to_not be_nil
    end
  end

  describe 'invoice.payment_succeeded' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('invoice.payment_succeeded')
      invoice_object = event.data.object
      expect(invoice_object.id).to_not be_nil
      expect(invoice_object.charge).to_not be_nil
      expect(invoice_object.subscription).to_not be_nil
    end
  end

  describe 'invoice.payment_failed' do
    it 'mocks a stripe webhook' do
      event = StripeMock.mock_webhook_event('invoice.payment_failed')
      invoice_object = event.data.object
      expect(invoice_object.id).to_not be_nil
      expect(invoice_object.charge).to_not be_nil
      expect(invoice_object.subscription).to_not be_nil
    end
  end
end