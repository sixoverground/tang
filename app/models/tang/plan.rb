module Tang
  class Plan < ActiveRecord::Base
    has_paper_trail

    has_many :subscriptions

    validates :stripe_id, uniqueness: true
    validates :name, presence: true
    validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :currency, length: { is: 3 }
    validates :interval, inclusion: { in: %w(day week month year) }
    validates :interval_count, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true # TODO: restrict this to max 1 year time
    validates :trial_period_days, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
    validates :statement_descriptor, length: { maximum: 22 }, allow_nil: true # TODO: don't allow <>"' characters

    after_initialize :default_values
    before_create :create_stripe_plan
    before_update :update_stripe_plan
    before_destroy :delete_stripe_plan

    private

    def default_values
      self.currency = Tang.default_currency if self.currency.nil?
      self.order = 0 if self.order.nil?
    end

    def create_stripe_plan
      CreatePlan.call(self)
    end

    def update_stripe_plan
      UpdatePlan.call(self)
    end

    def delete_stripe_plan
      DeletePlan.call(self)
    end
  end
end
