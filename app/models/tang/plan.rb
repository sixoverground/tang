module Tang
  class Plan < ActiveRecord::Base
    has_paper_trail
    # acts_as_paranoid

    has_many :subscriptions

    validates :stripe_id, presence: true
    validates :stripe_id, uniqueness: true # , if: "deleted_at.nil?"
    validates :name, presence: true
    validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :currency, length: { is: 3 }
    validates :interval, inclusion: { in: %w[day week month year] }
    validates :interval_count, numericality: {
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: 1
    }, allow_nil: true, if: -> { interval == 'year' }
    validates :interval_count, numericality: {
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: 12
    }, allow_nil: true, if: -> { interval == 'month' }
    validates :interval_count, numericality: {
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: 52
    }, allow_nil: true, if: -> { interval == 'week' }
    validates :interval_count, numericality: {
      only_integer: true,
      greater_than: 0,
      less_than_or_equal_to: 365
    }, allow_nil: true, if: -> { interval == 'day' }
    validates :trial_period_days, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
    validates :statement_descriptor, length: { maximum: 22 }, format: { without: /[<>"']/ }, allow_nil: true

    after_initialize :default_values
    before_create :create_stripe_plan
    before_update :update_stripe_plan
    before_destroy :delete_stripe_plan # should be soft delete

    INTERVALS = %w[day week month year].freeze

    def period_days_from(date)
      return date + interval_count.weeks if interval == 'week'

      return date + interval_count.months if interval == 'month'

      return date + interval_count.years if interval == 'year'

      date + interval_count.days
    end

    def interval_count
      self[:interval_count] || 1
    end

    private

    def default_values
      self.currency = Tang.default_currency if currency.nil?
      self.order = 0 if order.nil?
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
