module Tang
  class PlanService
    def create(options={})
      plan = Plan.new(options)

      if !plan.valid?
        return plan
      end

      begin
        Stripe::Plan.create(
          id: options[:stripe_id],
          amount: options[:amount],
          currency: options[:currency],
          interval: options[:interval],
          interval_count: options[:interval_count],
          name: options[:name],
          statement_descriptor: options[:statement_descriptor],
          trial_period_days: options[:trial_period_days]
        )
      rescue Stripe::StripeError => e
        plan.errors[:base] << e.message
        return plan
      end

      plan.save

      return plan
    end
  end
end