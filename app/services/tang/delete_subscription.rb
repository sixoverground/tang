module Tang
  class DeleteSubscription
    def self.call(subscription)
      begin
        s = Stripe::Subscription.retrieve(subscription.stripe_id)
        s.delete
      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end
      return subscription
    end
  end
end