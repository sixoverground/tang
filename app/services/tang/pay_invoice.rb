module Tang
  class PayInvoice
    def self.call(stripe_invoice)
      # ensure the subscription exists
      stripe_subscription = Stripe::Subscription.retrieve(stripe_invoice.subscription)
      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)
      if subscription.nil?
        subscription = Subscription.from_stripe(stripe_subscription)
      elsif stripe_subscription.discount.nil?
        # update discount
        subscription.update(coupon: nil, coupon_start: nil)
      end

      # create the invoice
      invoice = Invoice.from_stripe(stripe_invoice)

      # create charge
      charge = nil
      if stripe_invoice.charge.present?
        stripe_charge = Stripe::Charge.retrieve(stripe_invoice.charge)
        charge = Charge.from_stripe(stripe_charge, invoice)
      end

      # update customer active until
      if subscription.present?
        customer = subscription.customer
        customer.update_subscription_end(subscription)
      end

      charge
    end
  end
end
