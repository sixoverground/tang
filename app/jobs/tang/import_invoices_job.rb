module Tang
  class ImportInvoicesJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      # Do something later
      stripe_invoices = Stripe::Invoice.list(limit: 100, starting_after: starting_after)
      stripe_invoices.each do |stripe_invoice|
        invoice = Invoice.from_stripe(stripe_invoice)
        next unless invoice.present?

        stripe_invoice.lines.data.each do |stripe_invoice_item|
          InvoiceItem.from_stripe(stripe_invoice_item, invoice)
        end
      end

      return unless stripe_invoices.has_more

      Tang::ImportInvoicesJob.perform_now(stripe_invoices.data.last.id)
    end
  end
end
