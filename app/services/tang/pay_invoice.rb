module Tang
  class PayInvoice
    def self.call(stripe_invoice)

      # ensure the subscription exists
      stripe_subscription = Stripe::Subscription.retrieve(stripe_invoice.subscription)
      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)
      if subscription.nil?
        subscription = Subscription.from_stripe(stripe_subscription)
      end

      # create the invoice
      invoice = Invoice.from_stripe(stripe_invoice)

      # create charge
      charge = nil
      if stripe_invoice.charge.present?
        stripe_charge = Stripe::Charge.retrieve(stripe_invoice.charge)
        charge = Charge.from_stripe(stripe_charge, invoice)
      end

      # update discount
      if stripe_subscription.discount.nil?
        subscription.update(coupon: nil, coupon_start: nil)
      end

      # update customer active until
      customer = subscription.customer
      customer.update_subscription_end(subscription)

      return charge
    end
  end
end