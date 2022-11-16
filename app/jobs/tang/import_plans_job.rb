module Tang
  class ImportPlansJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      # Do something later
      stripe_plans = Stripe::Plan.list(limit: 100, starting_after: starting_after, expand: ['data.product'])
      stripe_plans.each do |stripe_plan|
        Plan.find_or_create_by(stripe_id: stripe_plan.id) do |p|
          p.amount = stripe_plan.amount
          p.currency = stripe_plan.currency
          p.interval = stripe_plan.interval
          p.interval_count = stripe_plan.interval_count
          p.name = stripe_plan.product.name
          p.statement_descriptor = stripe_plan.statement_descriptor
          p.trial_period_days = stripe_plan.trial_period_days
        end
      end

      Tang::ImportPlansJob.perform_now(stripe_plans.data.last.id) if stripe_plans.has_more
    end
  end
end
