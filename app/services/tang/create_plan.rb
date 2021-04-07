module Tang
  class CreatePlan
    def self.call(plan)
      if !plan.valid?
        return plan
      end

      begin
        Stripe::Plan.create(
          id: plan.stripe_id,
          name: plan.name,
          currency: plan.currency,
          amount: plan.amount,
          interval: plan.interval,
          interval_count: plan.interval_count,
          trial_period_days: plan.trial_period_days,
          statement_descriptor: plan.statement_descriptor,
        )
      rescue Stripe::StripeError => e
        plan.errors.add(:base, :invalid, message: e.message)
        return plan
      end

      return plan
    end
  end
end