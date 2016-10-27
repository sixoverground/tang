module Tang
  class PayInvoice
    def self.call(event)
      stripe_invoice = event.data.object

      invoice = Invoice.find_by(stripe_id: stripe_invoice.id)

      # create charge
      stripe_charge = Stripe::Charge.retrieve(stripe_invoice.charge)
      charge = Charge.create(
        stripe_id: stripe_charge.id,
        invoice: invoice,
        amount: stripe_charge.amount,
        currency: stripe_charge.currency,
        description: stripe_charge.description,
        receipt_email: stripe_charge.receipt_email,
        statement_descriptor: stripe_charge.statement_descriptor
      )

      # update subscription
      stripe_subscription = Stripe::Subscription.retrieve(stripe_invoice.subscription)
      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)
      # subscription.update_from_stripe(stripe_subscription)

      # update customer active until
      # customer = Tang.customer_class.find_by(stripe_id: stripe_invoice.customer)
      customer = subscription.customer
      customer.update_subscription_end(stripe_subscription)

      return charge
    end
  end
end