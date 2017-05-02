module Tang
  class ImportChargesJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      # Do something later
      stripe_charges = Stripe::Charge.list(limit: 100, starting_after: starting_after)
      stripe_charges.each do |stripe_charge|

        invoice = Invoice.find_by(stripe_id: stripe_charge.invoice)

        if invoice.present?
          Charge.from_stripe(stripe_charge, invoice)
        end

      end

      if stripe_charges.has_more
        Tang::ImportChargesJob.perform_now(stripe_charges.data.last.id)
      end
    end
  end
end
