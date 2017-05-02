module Tang
  class ImportSubscriptionsJob < ActiveJob::Base
    queue_as :default

    def perform
      # Make sure we don't email everyone
      Subscription.skip_callback(:save, :before, :check_for_upgrade)

      # Import all Stripe subscriptions
      Stripe::Subscription.list(status: 'all').each do |stripe_subscription|
        puts "looking at stripe subscription: #{stripe_subscription.id}"
        customer = Tang.customer_class.find_by(stripe_id: stripe_subscription.customer)
        puts "customer: #{customer.id}" if customer.present?
        plan = Plan.find_by(stripe_id: stripe_subscription.plan.id)
        puts "plan: #{plan.id}" if plan.present?
        if customer.present? && plan.present?
          subscription = Subscription.find_or_create_by(stripe_id: stripe_subscription.id) do |s|
            s.customer = customer
            s.plan = plan
            s.application_fee_percent = stripe_subscription.application_fee_percent
            s.quantity = stripe_subscription.quantity
            s.tax_percent = stripe_subscription.tax_percent
            s.trial_end = stripe_subscription.trial_end
            s.coupon = Coupon.find_by(stripe_id: stripe_subscription.discount.coupon.id) if stripe_subscription.discount.present?
            s.status = stripe_subscription.status
          end
          puts "tang subscription: #{subscription.id}"
          
          # Handle removed discounts
          if stripe_subscription.discount.nil?
            subscription.update(coupon: nil, coupon_start: nil)
          end
        end
      end

      # All done, enable the mailer
      Subscription.set_callback(:save, :before, :check_for_upgrade)
    end
  end
end
