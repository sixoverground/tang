module Tang
  class ImportInvoicesJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Invoice.list.each do |stripe_invoice|
        invoice = Invoice.from_stripe(stripe_invoice)
        if invoice.present?
          stripe_invoice.lines.data.each do |stripe_invoice_item|
            invoice_item = InvoiceItem.from_stripe(stripe_invoice_item, invoice)
          end
        end
      end
    end
  end
end
