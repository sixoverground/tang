module Tang
  class ImportChargesJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Charge.list.each do |stripe_charge|

        invoice = Invoice.find_by(stripe_id: stripe_charge.invoice)

        if invoice.present?
          Charge.from_stripe(stripe_charge, invoice)
        end

      end
    end
  end
end
