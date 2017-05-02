module Tang
  class ImportSubscriptionsJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      # Make sure we don't email everyone
      Subscription.skip_callback(:save, :before, :check_for_upgrade)

      # Import all Stripe subscriptions
      stripe_subscriptions = Stripe::Subscription.list(status: 'all', limit: 100, starting_after: starting_after)
      stripe_subscriptions.each do |stripe_subscription|
        puts "looking at stripe subscription: #{stripe_subscription.id}"
        customer = Tang.customer_class.find_by(stripe_id: stripe_subscription.customer)
        puts "customer: #{customer.id}" if customer.present?
        plan = Plan.find_by(stripe_id: stripe_subscription.plan.id)
        puts "plan: #{plan.id}" if plan.present?
        if customer.present? && plan.present?
          subscription = Subscription.from_stripe(stripe_subscription, customer, plan)
          puts "tang subscription: #{subscription.id}"

          # Handle removed discounts
          if stripe_subscription.discount.nil?
            subscription.update(coupon: nil, coupon_start: nil)
          end
        end
      end

      # All done, enable the mailer
      Subscription.set_callback(:save, :before, :check_for_upgrade)

      if stripe_subscriptions.has_more
        Tang::ImportSubscriptionsJob.perform_now(stripe_subscriptions.data.last.id)
      end
    end
  end
end
