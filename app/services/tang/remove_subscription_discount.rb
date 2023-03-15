module Tang
  class RemoveSubscriptionDiscount
    def self.call(subscription)
      begin
        Stripe::Subscription.retrieve(subscription.stripe_id).delete_discount
      rescue Stripe::StripeError => e
        subscription.errors.add(:base, :invalid, message: e.message)
      end

      subscription.update(coupon: nil, coupon_start: nil)

      subscription
    end
  end
end
