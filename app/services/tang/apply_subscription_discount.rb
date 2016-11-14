module Tang
  class ApplySubscriptionDiscount
    def self.call(subscription, coupon)
      begin
        sub = Stripe::Subscription.retrieve(subscription.stripe_id)
        sub.coupon = coupon.stripe_id
        sub.save
      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end

      subscription.update(coupon: coupon)

      return subscription
    end
  end
end