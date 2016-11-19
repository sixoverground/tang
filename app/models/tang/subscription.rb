module Tang
  class Subscription < ActiveRecord::Base
    has_paper_trail

    belongs_to :customer, class_name: Tang.customer_class.to_s
    belongs_to :plan
    belongs_to :coupon
    has_many :invoices

    validates :customer, presence: true, uniqueness: true
    validates :plan, presence: true
    validates :stripe_id, presence: true, uniqueness: true
    validates :application_fee_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :quantity, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :tax_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true,
                            format: { with: /\A\d+(?:\.\d{0,4})?\z/ }

    # before_save :nil_if_blank
    before_update :update_stripe_subscription
    before_destroy :cancel_stripe_subscription

    STATUSES = ['trialing', 'active', 'past_due', 'canceled', 'unpaid']

    def period_start
      invoice = invoices.last
      if invoice.present?
        return invoice.period_start
      end
      return created_at
    end

    def period_end
      plan.period_days_from(period_start)
    end

    def quantity
      self[:quantity] || 1
    end

    def stripe_trial_end
      return 'now' if self.end_trial_now
      return self.trial_end.to_i if self.trial_end.present?
      return nil
    end

    def end_trial_now
      @end_trial_now || false
    end

    def end_trial_now=(val)
      @end_trial_now = val
    end

    private

    # def nil_if_blank
    #   self.trial_end = nil if self.trial_end.blank?
    # end

    def update_stripe_subscription
      UpdateSubscription.call(self)
    end

    def cancel_stripe_subscription
      CancelSubscription.call(self)
    end
  end
end
