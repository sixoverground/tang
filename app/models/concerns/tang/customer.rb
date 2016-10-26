require 'active_support/concern'

module Tang
  module Customer
    extend ActiveSupport::Concern

    included do
      has_one :card, class_name: 'Tang::Card', foreign_key: 'customer_id'
      has_one :subscription, class_name: 'Tang::Subscription', foreign_key: 'customer_id'

      before_update :update_stripe_customer
      before_destroy :delete_stripe_customer

      validates :stripe_id, uniqueness: true
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

    private

    def update_stripe_customer
      UpdateCustomer.call(self)
    end

    def delete_stripe_customer
      DeleteCustomer.call(self)
    end
  end
end
