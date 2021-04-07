module Tang
  class DeletePlan
    def self.call(plan)
      begin
        p = Stripe::Plan.retrieve(plan.stripe_id)
        p.delete
      rescue Stripe::StripeError => e
        plan.errors.add(:base, :invalid, message: e.message)
      end
      return plan
    end
  end
end