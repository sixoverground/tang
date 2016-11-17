require 'active_support/concern'

module Tang
  module Customer
    extend ActiveSupport::Concern

    included do
      has_one :card, class_name: 'Tang::Card', foreign_key: 'customer_id'
      has_one :subscription, class_name: 'Tang::Subscription', foreign_key: 'customer_id'
      belongs_to :coupon, class_name: 'Tang::Coupon'
      has_many :invoices, class_name: 'Tang::Invoice', foreign_key: 'customer_id'
      has_many :charges, through: :invoices, class_name: 'Tang::Charge'

      before_save :nil_if_blank
      before_update :update_stripe_customer
      before_destroy :delete_stripe_customer

      validates :stripe_id, uniqueness: true, allow_nil: true
      validates :account_balance, numericality: { only_integer: true }, allow_nil: true

      define_method :admin? do
        self.respond_to?(:role) && self.role == 'admin'
      end

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

    def subscribed_to?(stripe_id)
      if self.subscription.present? && self.subscription.plan.present? 
        return true if self.subscription.plan.stripe_id == stripe_id
        if Tang.plan_inheritance
          plan = Plan.find_by(stripe_id: stripe_id)
          return true if self.subscription.plan.order >= plan.order  
        end        
      end

      return false
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
