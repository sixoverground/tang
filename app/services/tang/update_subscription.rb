module Tang
  class UpdateSubscription
    def self.call(subscription)
      if !subscription.valid?
        return subscription
      end

      begin
        s = Stripe::Subscription.retrieve(subscription.stripe_id)
        s.plan = subscription.plan.stripe_id
        s.quantity = subscription.quantity
        s.trial_end = subscription.stripe_trial_end if subscription.stripe_trial_end.present?
        # s.tax_percent = subscription.tax_percent if subscription.tax_percent.present?
        s.coupon = subscription.coupon.stripe_id if subscription.coupon.present?
        s.save
      rescue Stripe::StripeError => e
        subscription.errors.add(:base, :invalid, message: e.message)
      end

      return subscription
    end
  end
end