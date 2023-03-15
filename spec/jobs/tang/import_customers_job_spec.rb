require 'rails_helper'

module Tang
  RSpec.describe ImportCustomersJob, type: :job do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    it 'imports customers from stripe' do
      customer = FactoryBot.create(:customer)
      count = Tang.customer_class.where.not(stripe_id: nil).count

      Stripe::Customer.create(
        {
          email: customer.email,
          source: stripe_helper.generate_card_token
        }
      )

      ImportCustomersJob.perform_now

      expect(Tang.customer_class.where.not(stripe_id: nil).count).to eq count + 1
    end
  end
end
