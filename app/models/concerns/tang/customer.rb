require 'active_support/concern'

module Tang
  module Customer
    extend ActiveSupport::Concern

    included do
      belongs_to :coupon, class_name: 'Tang::Coupon'
      belongs_to :subscription_coupon, class_name: 'Tang::Coupon'
      has_many :cards, class_name: 'Tang::Card', foreign_key: 'customer_id', dependent: :destroy
      has_many :subscriptions, class_name: 'Tang::Subscription', foreign_key: 'customer_id', dependent: :destroy
      has_many :invoices, class_name: 'Tang::Invoice', foreign_key: 'customer_id', dependent: :destroy
      has_many :charges, through: :invoices, class_name: 'Tang::Charge', dependent: :destroy

      before_save :nil_if_blank
      # before_update :update_stripe_customer
      before_destroy :delete_stripe_customer

      validates :stripe_id, uniqueness: true, allow_nil: true, if: :stripe_id_changed?
      validates :account_balance, numericality: { only_integer: true }, allow_nil: true

      define_method :admin? do
        self.respond_to?(:role) && self.role == 'admin'
      end

      define_method :stripe_enabled? do
        true
      end
    end

    def self.table_name
      return Tang.customer_class.to_s.downcase.pluralize
    end

    def self.search(query)
      customers = Tang.customer_class.none
      if query.present?
        q = "%#{query.downcase}%"
        customer_table = ActiveRecord::Base.connection.quote_table_name(Customer.table_name)
        customers = Tang.customer_class.
            joins(:subscriptions, :coupon).
            where.not(stripe_id: nil).
            where("lower(#{customer_table}.stripe_id) like ? or lower(#{customer_table}.email) like ? or lower(tang_subscriptions.stripe_id) like ? or lower(tang_coupons.stripe_id) like ?", 
                q, q, q, q).
            distinct
      end
      return customers
    end

    def card
      self.cards.order(:created_at).last
    end

    def subscription
      @subscription ||= self.subscriptions.where.not(status: :canceled).order(:created_at).last
    end

    def generate_password
      self.password = Devise.friendly_token.first(8)
    end

    def update_card_from_stripe(stripe_card)
      my_card = self.card.present? ? self.card : Card.new(customer: self)
      my_card.update_from_stripe(stripe_card)
    end

    def update_subscription_end(stripe_sub)
      timestamp = stripe_sub.current_period_end.to_s
      self.active_until = DateTime.strptime(timestamp, '%s')
      self.save!
    end

    # NOTE: May be causing memory bloat
    def subscribed_to?(stripe_id)
      if self.plan.present?
        return true if self.plan.stripe_id == stripe_id
        if Tang.plan_inheritance
          other_plan = Plan.find_by(stripe_id: stripe_id)
          return true if other_plan.present? && self.plan.order >= other_plan.order
        end
      end
      return false
    end

    def plan
      return self.subscription.plan if self.subscription.present?
      return nil
    end

    def coupon_end
      if coupon.present? && coupon.duration != 'forever'
        
      end
      return nil
    end

    def has_coupon?
      if self.subscription.present?
        if self.subscription.coupon.present?
          return true
        end
      end
      return self.coupon.present?
    end

    def has_subscription_coupon?
      return self.subscription.present? && self.subscription.coupon.present?
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

    def nil_if_blank
      self.description = nil if self.description.blank?
    end

    def update_stripe_customer
      UpdateCustomer.call(self)
    end

    def delete_stripe_customer
      DeleteCustomer.call(self)
    end
  end
end
