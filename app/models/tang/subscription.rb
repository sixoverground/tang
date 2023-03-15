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
    belongs_to :coupon, optional: true
    has_many :invoices, dependent: :destroy

    validates :customer, presence: true
    validates :plan, presence: true
    validates :stripe_id, presence: true, uniqueness: true
    validates :application_fee_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :quantity, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    # validates :tax_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true,
    #                         format: { with: /\A\d+(?:\.\d{0,4})?\z/ }

    # before_save :nil_if_blank
    before_update :update_stripe_subscription
    # before_destroy :destroy_stripe_subscription
    before_save :check_for_upgrade
    after_save :handle_upgrade

    attr_writer :end_trial_now, :upgraded

    STATUSES = %w[trialing active past_due canceled unpaid].freeze

    def self.from_stripe(stripe_subscription)
      customer = Tang.customer_class.find_by(stripe_id: stripe_subscription.customer)
      plan = Plan.find_by(stripe_id: stripe_subscription.plan.id)
      if customer.present? && plan.present?
        subscription = Subscription.build(stripe_subscription, customer, plan)
        subscription.update(coupon: nil, coupon_start: nil) if stripe_subscription.discount.nil?
        return subscription
      end
      nil
    end

    def self.build(stripe_subscription, customer, plan)
      Subscription.find_or_create_by(stripe_id: stripe_subscription.id) do |s|
        s.customer = customer
        s.plan = plan
        s.application_fee_percent = stripe_subscription.application_fee_percent
        s.quantity = stripe_subscription.quantity
        # s.tax_percent = stripe_subscription.tax_percent # removed from api in favor of tax rates
        if stripe_subscription.trial_end.present?
          s.trial_end = DateTime.strptime(stripe_subscription.trial_end.to_s, '%s')
        end
        if stripe_subscription.discount.present?
          s.coupon = Coupon.find_by(stripe_id: stripe_subscription.discount.coupon.id)
        end
        s.status = stripe_subscription.status
      end
    end

    def period_start
      invoice = invoices.order(:date).last
      return invoice.date if invoice.present?

      created_at
    end

    def period_end
      plan.period_days_from(period_start)
    end

    def quantity
      self[:quantity] || 1
    end

    def stripe_trial_end
      return 'now' if end_trial_now
      return trial_end.to_i if trial_end.present?

      nil
    end

    def end_trial_now
      @end_trial_now || false
    end

    def upgraded
      @upgraded || false
    end

    def discount_for_plan(plan)
      amount_off = 0
      if coupon.percent_off.present?
        amount_off = (coupon.percent_off.to_f / 100.0) * plan.amount.to_f
      elsif coupon.amount_off.present?
        amount_off = coupon.amount_off
      end
      amount_off
    end

    private

    # def nil_if_blank
    #   self.trial_end = nil if self.trial_end.blank?
    # end

    def check_for_upgrade
      return unless plan_id_changed?

      old_plan = Plan.find(plan_id_was) if plan_id_was.present?
      self.upgraded = true if old_plan.nil? || old_plan.order < plan.order
    end

    def handle_upgrade
      return unless upgraded

      if Tang.delayed_email
        SubscriptionMailer.upgraded(self).deliver_later
      else
        SubscriptionMailer.upgraded(self).deliver_now
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
