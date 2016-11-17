module Tang
  class Invoice < ActiveRecord::Base
    belongs_to :subscription
    belongs_to :customer, class_name: Tang.customer_class.to_s
    has_one :charge
    has_many :invoice_items
    belongs_to :coupon

    scope :paid, -> { joins(:charge) }

    def period_start
      self[:period_start] || created_at
    end

    def period_end
      self[:period_end] || subscription.plan.period_days_from(period_start)
    end

    def status
      if charge.present?
        'paid'
      else
        'unpaid'
      end
    end
  end
end
