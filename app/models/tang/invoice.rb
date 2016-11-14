module Tang
  class Invoice < ActiveRecord::Base
    belongs_to :subscription
    has_one :charge
    has_one :customer, through: :subscription

    def period_start
      self[:period_start] || created_at
    end

    def period_end
      self[:period_end] || subscription.plan.period_days_from(period_start)
    end
  end
end
