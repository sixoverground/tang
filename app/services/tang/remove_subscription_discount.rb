module Tang
  class RemoveSubscriptionDiscount
    def self.call(subscription)
      begin
        Stripe::Subscription.retrieve(subscription.stripe_id).delete_discount()
      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end

      subscription.update(coupon: nil)

      return subscription
    end
  end
end