module Tang
  class Subscription < ActiveRecord::Base
    has_paper_trail

    belongs_to :customer, class_name: Tang.customer_class
    belongs_to :plan

    validates :customer, uniqueness: true
    validates :stripe_id, uniqueness: true
    validates :application_fee_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :quantity, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
    validates :tax_percent, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

    before_destroy :cancel_stripe_subscription

    private

    def cancel_stripe_subscription
      CancelSubscription.call(self)
    end
  end
end
