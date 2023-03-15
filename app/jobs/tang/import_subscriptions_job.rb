module Tang
  class ImportSubscriptionsJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      # Make sure we don't email everyone
      Subscription.skip_callback(:save, :before, :check_for_upgrade)

      # Import all Stripe subscriptions
      stripe_subscriptions = Stripe::Subscription.list(status: 'all', limit: 100, starting_after: starting_after)
      stripe_subscriptions.each do |stripe_subscription|
        import_subscription(stripe_subscription)
      end

      # All done, enable the mailer
      Subscription.set_callback(:save, :before, :check_for_upgrade)

      Tang::ImportSubscriptionsJob.perform_now(stripe_subscriptions.data.last.id) if stripe_subscriptions.has_more
    end

    def import_subscription(stripe_subscription)
      subscription = Subscription.from_stripe(stripe_subscription)
      return unless subscription.present?

      # Handle removed discounts
      subscription.update(coupon: nil, coupon_start: nil) if stripe_subscription.discount.nil?
    end
  end
end
