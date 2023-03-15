module Tang
  class UpdatePlan
    def self.call(plan)
      return plan unless plan.valid?

      begin
        p = Stripe::Plan.retrieve(plan.stripe_id)
        p.name = plan.name
        p.save
      rescue Stripe::StripeError => e
        plan.errors.add(:base, :invalid, message: e.message)
      end

      plan
    end
  end
end
