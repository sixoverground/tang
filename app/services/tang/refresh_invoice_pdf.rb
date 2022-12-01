module Tang
  class RefreshInvoicePdf
    def self.call(invoice)
      stripe_invoice = Stripe::Invoice.retrieve(invoice.stripe_id)
      invoice.update(invoice_pdf: stripe_invoice.invoice_pdf)
      invoice
    end
  end
end
