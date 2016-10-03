module Tang
  class UpdatePlan
    def self.call(plan)
      if !plan.valid?
        return plan
      end

      begin
        p = Stripe::Plan.retrieve(plan.stripe_id)
        p.name = plan.name
        p.save
      rescue Stripe::StripeError => e
        plan.errors[:base] << e.message
      end

      return plan
    end
  end
end