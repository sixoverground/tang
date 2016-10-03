module Tang
  class ChangeSubscription
    def self.call(subscription, plan)
      if !subscription.valid?
        return subscription
      end
      
      begin
        stripe_sub = Stripe::Subscription.retrieve(subscription.stripe_id)
        stripe_sub.plan = plan.stripe_id
        stripe_sub.save
        subscription.plan = plan
        subscription.save!
      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end

      return subscription
    end
  end
end