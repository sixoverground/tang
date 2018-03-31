module Tang
  class PayInvoice
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
      stripe_subscription = Stripe::Subscription.retrieve(stripe_invoice.subscription)      
      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)

      # update discount
      if stripe_subscription.discount.nil?
        subscription.update(coupon: nil, coupon_start: nil)
      end

      # update customer active until
      customer = subscription.customer
      customer.update_subscription_end(stripe_subscription)

      return charge
    end
  end
end