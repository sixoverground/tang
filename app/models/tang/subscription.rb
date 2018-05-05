module Tang
  class Subscription < ActiveRecord::Base
    include AASM
    has_paper_trail

    aasm column: 'status' do
      state :trialing, initial: true
      state :active
      state :past_due
      state :canceled
      state :unpaid

      event :activate do
        transitions from: :trialing, to: :active
      end

      event :fail do
        transitions from: [:trialing, :active], to: :past_due
      end

      event :cancel, after: :cancel_stripe_subscription do
        transitions from: [:trialing, :active, :past_due], to: :canceled
      end

      event :close do
        transitions from: :past_due, to: :unpaid
      end
    end

    belongs_to :customer, class_name: Tang.customer_class.to_s
    belongs_to :plan
    belongs_to :coupon
    has_many :invoices, dependent: :destroy

    validates :customer, presence: true
    validates :plan, presence: true
    validates :stripe_id, presence: true, uniqueness: true
    validates :application_fee_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :quantity, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :tax_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true,
                            format: { with: /\A\d+(?:\.\d{0,4})?\z/ }

    # before_save :nil_if_blank
    before_update :update_stripe_subscription
    # before_destroy :destroy_stripe_subscription
    before_save :check_for_upgrade
    after_save :handle_upgrade

    STATUSES = ['trialing', 'active', 'past_due', 'canceled', 'unpaid']

    def self.from_stripe(stripe_subscription, customer, plan)
      subscription = Subscription.find_or_create_by(stripe_id: stripe_subscription.id) do |s|
        s.customer = customer
        s.plan = plan
        s.application_fee_percent = stripe_subscription.application_fee_percent
        s.quantity = stripe_subscription.quantity
        s.tax_percent = stripe_subscription.tax_percent
        s.trial_end = stripe_subscription.trial_end
        s.coupon = Coupon.find_by(stripe_id: stripe_subscription.discount.coupon.id) if stripe_subscription.discount.present?
        s.status = stripe_subscription.status
      end
      return subscription
    end

    def period_start
      invoice = invoices.last
      if invoice.present?
        return invoice.period_start
      end
      return created_at
    end

    def period_end
      invoice = invoices.last
      if invoice.present?
        return invoice.period_end
      end
      return plan.period_days_from(period_start)
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

    def upgraded
      @upgraded || false
    end

    def upgraded=(val)
      @upgraded = val
    end

    def discount_for_plan(plan)
      amount_off = 0
      if self.coupon.percent_off.present?
        amount_off = (self.coupon.percent_off.to_f / 100.0) * plan.amount.to_f
      elsif self.coupon.amount_off.present?
        amount_off = self.coupon.amount_off
      end
      return amount_off
    end

    private

    # def nil_if_blank
    #   self.trial_end = nil if self.trial_end.blank?
    # end

    def check_for_upgrade
      if plan_id_changed?
        old_plan = Plan.find(plan_id_was) if plan_id_was.present?
        self.upgraded = true if old_plan.nil? || old_plan.order < plan.order
      end
    end

    def handle_upgrade
      if self.upgraded
        if Tang.delayed_email
          SubscriptionMailer.upgraded(self).deliver_later
        else
          SubscriptionMailer.upgraded(self).deliver_now
        end
      end
    end

    def update_stripe_subscription
      UpdateSubscription.call(self)
    end

    def cancel_stripe_subscription
      CancelSubscription.call(self)
    end
  end
end
