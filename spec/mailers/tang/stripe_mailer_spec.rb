require "rails_helper"

module Tang
  RSpec.describe StripeMailer, type: :mailer do
    before { StripeMock.start }
    after { StripeMock.stop }

    describe 'admin_dispute_created' do
      it 'should send a dispute notification' do
        charge = FactoryGirl.create(:charge)

        event = StripeMock.mock_webhook_event('charge.dispute.created', charge: charge.stripe_id)

        mail = StripeMailer.admin_dispute_created(event.data.object)
        expect(mail.subject).to eq "Dispute created on charge #{charge.stripe_id}"
      end
    end

    describe 'admin_charge_succeded' do
      it 'should send a charge succeeded notification' do
        charge = FactoryGirl.create(:charge)
        mail = StripeMailer.admin_charge_succeeded(charge)
        expect(mail.subject).to eq "Woo! Charge succeeded!"
      end
    end

    describe 'receipt' do
      it 'should send a receipt' do
        charge = FactoryGirl.create(:charge)
        mail = StripeMailer.receipt(charge)
        expect(mail.subject).to eq "Thank you!"
      end
    end


  end
end
