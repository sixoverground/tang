module Tang
  class ApplySubscriptionDiscount
    def self.call(subscription, coupon)
      begin
        sub = Stripe::Subscription.retrieve(subscription.stripe_id)
        sub.coupon = coupon.stripe_id
        sub.save

        if sub.discount.methods.include? 'start'
          start = sub.discount.start.to_s
          start_timestamp = DateTime.strptime(start, '%s')
        else
          start_timestamp = Time.now
        end
        subscription.update(coupon: coupon, coupon_start: start_timestamp)
      rescue Stripe::StripeError => e
        subscription.errors.add(:base, :invalid, message: e.message)
      end

      return subscription
    end
  end
end