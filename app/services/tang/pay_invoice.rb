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
        statement_descriptor: stripe_charge.statement_descriptor,

        # Save payment source at time of purchase
        card_stripe_id: stripe_charge.source.id,
        card_address_city: stripe_charge.source.address_city,
        card_address_country: stripe_charge.source.address_country,
        card_address_line1: stripe_charge.source.address_line1,
        card_address_line1_check: stripe_charge.source.address_line1_check,
        card_address_line2: stripe_charge.source.address_line2,
        card_address_state: stripe_charge.source.address_state,
        card_address_zip: stripe_charge.source.address_zip,
        card_address_zip_check: stripe_charge.source.address_zip_check,
        card_brand: stripe_charge.source.brand,
        card_country: stripe_charge.source.country,
        card_cvc_check: stripe_charge.source.cvc_check,
        # card_dynamic_last4: stripe_charge.source.dynamic_last4,
        card_exp_month: stripe_charge.source.exp_month,
        card_exp_year: stripe_charge.source.exp_year,
        card_fingerprint: stripe_charge.source.fingerprint,
        card_funding: stripe_charge.source.funding,
        card_last4: stripe_charge.source.last4,
        card_name: stripe_charge.source.name,
        # card_tokenization_method: stripe_charge.source.tokenization_method
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