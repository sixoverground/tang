module Tang
  class ImportPlansJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Plan.list.each do |stripe_plan|
        Plan.find_or_create_by(stripe_id: stripe_plan.id) do |p|
          p.amount = stripe_plan.amount
          p.currency = stripe_plan.currency
          p.interval = stripe_plan.interval
          p.interval_count = stripe_plan.interval_count
          p.name = stripe_plan.name
          p.statement_descriptor = stripe_plan.statement_descriptor
          p.trial_period_days = stripe_plan.trial_period_days
        end

      end
    end
  end
end
