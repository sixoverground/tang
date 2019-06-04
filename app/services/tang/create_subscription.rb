module Tang
  class CreateSubscription
    def self.call(plan, customer, token)
      subscription = Subscription.new(
        plan: plan, 
        customer: customer, 
        coupon: customer.subscription_coupon
      )
      return subscription if plan.nil? || customer.nil?

      # TODO: Check for token presence. 
      # A nil token will throw an error when calling create_stripe_subscription 
      # because the customer does not have a payment method.

      begin
        if customer.stripe_id.blank?
          # Create a new subscription and customer
          stripe_customer = create_stripe_customer(customer, token)
          customer.stripe_id = stripe_customer.id
        else
          # Update the payment method
          stripe_customer = update_stripe_customer(customer, token)
        end

        # Subscribe
        stripe_sub = create_stripe_subscription(customer, plan)

        # Save the subscription
        subscription.stripe_id = stripe_sub.id
        subscription.trial_end = DateTime.strptime(stripe_sub.trial_end.to_s, '%s') if stripe_sub.trial_end.present?
        subscription.activate!

        # Save the payment method
        stripe_card = stripe_customer.sources.retrieve(stripe_customer.default_source)

        # Finalize customer with subscription and payment method
        finalize_customer(customer, stripe_sub, stripe_card)

      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end
      return subscription
    end

    def self.create_stripe_customer(customer, token)
      if customer.coupon.present?
        stripe_customer = Stripe::Customer.create(
          source: token,
          email: customer.email,
          coupon: customer.coupon.stripe_id
        )
      else
        stripe_customer = Stripe::Customer.create(
          source: token,
          email: customer.email
        )
      end
      return stripe_customer
    end

    def self.update_stripe_customer(customer, token)
      # Update the payment method
      stripe_customer = Stripe::Customer.retrieve(customer.stripe_id)
      if token.present?
        stripe_customer.source = token
        stripe_customer.save
      end
      return stripe_customer
    end

    def self.create_stripe_subscription(customer, plan)
      if customer.subscription_coupon.present?
        stripe_sub = Stripe::Subscription.create(
          customer: customer.stripe_id,
          plan: plan.stripe_id,
          coupon: customer.subscription_coupon.stripe_id
        )
      else
        stripe_sub = Stripe::Subscription.create(
          customer: customer.stripe_id,
          plan: plan.stripe_id
        )
      end
      return stripe_sub
    end

    def self.finalize_customer(customer, stripe_sub, stripe_card)
      # Remove temporary coupon
      customer.subscription_coupon = nil
      # Save subscription data to customer
      customer.update_subscription_end(stripe_sub)
      # Save the payment method
      customer.update_card_from_stripe(stripe_card)
    end
  end
end