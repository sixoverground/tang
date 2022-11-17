module Tang
  class CreatePlan
    def self.call(plan)
      return plan unless plan.valid?

      begin
        stripe_product = Stripe::Product.create({ name: plan.name, type: 'service' })

        Stripe::Plan.create(
          id: plan.stripe_id,
          # name: plan.name,
          product: stripe_product.id,
          currency: plan.currency,
          amount: plan.amount,
          interval: plan.interval,
          interval_count: plan.interval_count,
          trial_period_days: plan.trial_period_days
          # statement_descriptor: plan.statement_descriptor
        )
      rescue Stripe::StripeError => e
        plan.errors.add(:base, :invalid, message: e.message)
        return plan
      end

      plan
    end
  end
end
