module Tang
  class UpdateSubscription
    def self.call(subscription)
      if !subscription.valid?
        return subscription
      end

      begin

        puts "TRIAL END: #{subscription.trial_end}"
        puts "NIL: #{subscription.trial_end.nil?}"
        puts "STRIPE TRIAL END: #{subscription.stripe_trial_end}"
        puts "END TRIAL NOW: #{subscription.end_trial_now}"

        s = Stripe::Subscription.retrieve(subscription.stripe_id)
        s.plan = subscription.plan.stripe_id
        s.quantity = subscription.quantity
        s.trial_end = subscription.stripe_trial_end if subscription.stripe_trial_end.present?
        s.tax_percent = subscription.tax_percent
        if subscription.coupon.present?
          s.coupon = subscription.coupon.stripe_id
        end
        s.save
      rescue Stripe::StripeError => e
        subscription.errors[:base] << e.message
      end

      return subscription
    end
  end
end