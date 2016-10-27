module Tang
  class CreateInvoice
    def self.call(event)
      stripe_invoice = event.data.object

      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)

      invoice = Invoice.find_or_create_by(stripe_id: stripe_invoice.id) do |i|
        i.subscription = subscription
        i.period_start = stripe_invoice.period_start
        i.period_end = stripe_invoice.period_end
        i.date = stripe_invoice.date
        i.total = stripe_invoice.total
        i.currency = stripe_invoice.currency
      end

      return invoice
    end
  end
end