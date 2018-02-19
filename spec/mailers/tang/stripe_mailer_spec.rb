require "rails_helper"

module Tang
  RSpec.describe StripeMailer, type: :mailer do
    before { StripeMock.start }
    after { StripeMock.stop }

    describe 'admin_dispute_created' do
      it 'should send a dispute notification' do
        charge = FactoryBot.create(:charge)

        event = StripeMock.mock_webhook_event('charge.dispute.created', charge: charge.stripe_id)

        dispute = event.data.object
        dispute_charge = Charge.find_by(stripe_id: dispute.charge)

        mail = StripeMailer.admin_dispute_created(dispute_charge)
        expect(mail.subject).to eq "Dispute created on charge #{charge.stripe_id}"
      end
    end

    describe 'admin_payment_succeeded' do
      it 'should send a payment succeeded notification' do
        charge = FactoryBot.create(:charge)
        mail = StripeMailer.admin_payment_succeeded(charge)
        expect(mail.subject).to eq "Woo! Charge succeeded!"
      end
    end

    describe 'customer_payment_succeeded' do
      it 'should send a receipt' do
        charge = FactoryBot.create(:charge)
        mail = StripeMailer.customer_payment_succeeded(charge)
        expect(mail.subject).to eq "Thank you!"
      end
    end


  end
end
