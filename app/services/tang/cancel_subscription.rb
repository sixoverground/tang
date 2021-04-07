module Tang
  class CancelSubscription
    def self.call(subscription)
      begin
        s = Stripe::Subscription.retrieve(subscription.stripe_id)
        s.delete
      rescue Stripe::StripeError => e
        subscription.errors.add(:base, :invalid, message: e.message)
      end
      return subscription
    end
  end
end