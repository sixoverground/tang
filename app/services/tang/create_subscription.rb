module Tang
  class CreateSubscription
    def self.call(plan, customer, token)
      subscription = Subscription.new(plan: plan, customer: customer)
      return subscription if !subscription.valid?

      begin
        if customer.stripe_id.blank?
          # Create a new subscription and customer
          if customer.coupon.present?
            stripe_customer = Stripe::Customer.create(
              source: token, 
              plan: plan.stripe_id, 
              email: customer.email,
              coupon: customer.coupon.stripe_id
            )
          else
            stripe_customer = Stripe::Customer.create(
              source: token, 
              plan: plan.stripe_id, 
              email: customer.email
            )
          end
          customer.stripe_id = stripe_customer.id
          stripe_sub = stripe_customer.subscriptions.first
        else
          # Update the payment method
          stripe_customer = Stripe::Customer.retrieve(customer.stripe_id)
          if token.present?
            stripe_customer.source = token
            stripe_customer.save
          end
          # Subscribe
          stripe_sub = Stripe::Subscription.create(customer: stripe_customer.id, plan: plan.stripe_id)
        end

        # Save the subscription
        subscription.stripe_id = stripe_sub.id
        subscription.trial_end = DateTime.strptime(stripe_sub.trial_end.to_s, '%s') if stripe_sub.trial_end.present?
        subscription.save!

        # Save subscription data to customer
        customer.update_subscription_end(stripe_sub)

        # Save the payment method
        stripe_card = stripe_customer.sources.retrieve(stripe_customer.default_source)
        customer.update_card_from_stripe(stripe_card)

      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end
      return subscription
    end
  end
end