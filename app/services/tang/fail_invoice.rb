module Tang
  class FailInvoice
    def self.call(stripe_invoice)
      invoice = Invoice.find_by(stripe_id: stripe_invoice.id)

      # create charge
      stripe_charge = Stripe::Charge.retrieve(stripe_invoice.charge)
      charge = Charge.from_stripe(stripe_charge, invoice)

      # update subscription
      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)
      subscription.fail!

      return charge
    end
  end
end