module Tang
  class CreateSubscription
    def self.call(plan, customer, token)
      subscription = Subscription.new(
        plan: plan,
        customer: customer
      )

      if !subscription.valid?
        return subscription
      end

      begin

        if customer.stripe_id.blank?

          # Create a new subscription and customer
          stripe_customer = Stripe::Customer.create(
            source: token,
            plan: plan.stripe_id,
            email: customer.email
          )
          customer.stripe_id = stripe_customer.id
          customer.save!
          stripe_sub = stripe_customer.subscriptions.first
        else
          # Update the payment method
          stripe_customer = Stripe::Customer.retrieve(customer.stripe_id)
          if token.present?
            stripe_customer.source = token
            stripe_customer.save
          end

          # Subscribe
          stripe_sub = Stripe::Subscription.create(
            customer: stripe_customer.id,
            plan: plan.stripe_id
          )
        end

        subscription.stripe_id = stripe_sub.id
        subscription.save!

        # Save the payment method
        stripe_card = stripe_customer.sources.retrieve(stripe_customer.default_source)
        if customer.card.present?
          card = customer.card
        else
          card = Card.new(customer: customer)
        end
        card.stripe_id = stripe_card.id
        card.address_city = stripe_card.address_city
        card.address_country = stripe_card.address_country
        card.address_line1 = stripe_card.address_line1
        card.address_line1_check = stripe_card.address_line1_check
        card.address_line2 = stripe_card.address_line2
        card.address_state = stripe_card.address_state
        card.address_zip = stripe_card.address_zip
        card.address_zip_check = stripe_card.address_zip_check
        card.brand = stripe_card.brand
        card.country = stripe_card.country
        card.cvc_check = stripe_card.cvc_check
        # card.dynamic_last4 = stripe_card.dynamic_last4
        card.exp_month = stripe_card.exp_month
        card.exp_year = stripe_card.exp_year
        card.fingerprint = stripe_card.fingerprint
        card.funding = stripe_card.funding
        card.last4 = stripe_card.last4
        card.name = stripe_card.name
        # card.tokenization_method = stripe_card.tokenization_method
        card.save!

      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end

      return subscription
    end
  end
end