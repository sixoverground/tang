module Tang
  class ImportSubscriptionsJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Subscription.list.each do |stripe_subscription|
        customer = Tang.customer_class.find_by(stripe_id: stripe_subscription.customer)
        plan = Plan.find_by(stripe_id: stripe_subscription.plan.id)
        if customer.present? && plan.present?
          subscription = Subscription.find_or_create_by(stripe_id: stripe_subscription.id) do |s|
            s.customer = customer
            s.plan = plan
            s.application_fee_percent = stripe_subscription.application_fee_percent
            s.quantity = stripe_subscription.quantity
            s.tax_percent = stripe_subscription.tax_percent
            s.trial_end = stripe_subscription.trial_end
            s.coupon = Coupon.find_by(stripe_id: stripe_subscription.discount.coupon.id) if stripe_subscription.discount.present?
          end
        end
      end
    end
  end
end
