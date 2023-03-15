module Tang
  class FailInvoice
    def self.call(stripe_invoice)
      # invoice = Invoice.find_by(stripe_id: stripe_invoice.id)
      invoice = Invoice.from_stripe(stripe_invoice)

      # create charge
      charge = nil
      if stripe_invoice.charge.present?
        stripe_charge = Stripe::Charge.retrieve(stripe_invoice.charge)
        charge = Charge.from_stripe(stripe_charge, invoice)
      end

      # update subscription
      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)
      if subscription.nil?
        stripe_subscription = Stripe::Subscription.retrieve(stripe_invoice.subscription)
        subscription = Subscription.from_stripe(stripe_subscription)
        invoice.update(subscription: subscription)
      end

      subscription.fail! if subscription.present? && !subscription.past_due?

      charge
    end
  end
end
