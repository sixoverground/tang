module Tang
  class CreateInvoice
    def self.call(event)
      stripe_invoice = event.data.object

      invoice = Invoice.from_stripe(stripe_invoice)

      if invoice.present?
        stripe_invoice.lines.data.each do |stripe_invoice_item|
          InvoiceItem.from_stripe(stripe_invoice_item, invoice)
        end
      end

      return invoice
    end
  end
end