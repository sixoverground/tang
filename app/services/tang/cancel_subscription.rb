module Tang
  class CancelSubscription
    def self.call(subscription)
      begin
        stripe_sub = Stripe::Subscription.retrieve(subscription.stripe_id)
        stripe_sub.delete
      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end
      return subscription
    end
  end
end