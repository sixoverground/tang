module Tang
  class ImportChargesJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Charge.list.each do |stripe_charge|

        invoice = Invoice.find_by(stripe_id: stripe_charge.invoice)

        if invoice.present?
          Charge.find_or_create_by(stripe_id: stripe_charge.id) do |c|
            c.invoice = invoice
            c.amount = stripe_charge.amount
            c.currency = stripe_charge.currency
            c.description = stripe_charge.description
            c.receipt_email = stripe_charge.receipt_email
            c.statement_descriptor = stripe_charge.statement_descriptor
          end
        end

      end
    end
  end
end
