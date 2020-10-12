module Tang
  class Coupon < ActiveRecord::Base
    has_paper_trail
    # acts_as_paranoid

    has_many :customers, class_name: Tang.customer_class.to_s
    has_many :subscriptions
    has_many :invoices

    validates :stripe_id, presence: true
    validates :stripe_id, uniqueness: true # , if: "deleted_at.nil?"
    validates :duration, inclusion: { in: %w(once repeating forever) }
    validates :amount_off, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
    validates :currency, presence: true, if: -> { amount_off.present? }
    validates :duration_in_months, presence: true, numericality: { only_integer: true, greater_than: 0 }, if: :repeating?
    validates :max_redemptions, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
    validates :percent_off, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 },
                            presence: true, if: -> { amount_off.nil? }
    validates :redeem_by, future: true, if: -> { redeem_by.present? }

    before_create :create_stripe_coupon
    before_update :update_stripe_coupon
    before_destroy :delete_stripe_coupon # should be soft delete

    DURATIONS = ['once', 'repeating', 'forever']

    def coupon_valid?
      # check if expired
      if self.redeem_by.present?
        return false if Time.now > self.redeem_by
      end

      if self.max_redemptions.present?
        # check if any discounts created
      end

      return true
    end

    def formatted_duration
      if repeating?
        "for #{duration_in_months} months"
      else
        duration
      end
    end

    def active_redemptions
      customer_table = ActiveRecord::Base.connection.quote_table_name(Customer.table_name)
      Tang.customer_class.
           joins(:subscriptions).
           where("#{customer_table}.coupon_id = ? OR tang_subscriptions.coupon_id = ?", self.id, self.id).
           where.not(tang_subscriptions: { status: :canceled }).
           uniq
    end

    def repeating?
      duration == "repeating"
    end

    def discount(amount)
      subtotal = amount
      if self.percent_off.present?
        subtotal = amount.to_f * (self.percent_off.to_f / 100.0)
      elsif self.amount_off.present?
        subtotal = self.amount_off
      end
      return -subtotal.to_f
    end

    def self.from_stripe(stripe_coupon)      
      coupon = Coupon.find_or_create_by(stripe_id: stripe_coupon.id) do |c|
        c.percent_off = stripe_coupon.percent_off
        c.currency = stripe_coupon.currency
        c.amount_off = stripe_coupon.amount_off
        c.duration = stripe_coupon.duration
        c.duration_in_months = stripe_coupon.duration_in_months
        c.max_redemptions = stripe_coupon.max_redemptions
        c.redeem_by = DateTime.strptime(stripe_coupon.redeem_by.to_s, '%s') if stripe_coupon.redeem_by.present?
      end

      return coupon
    end

    private

    def create_stripe_coupon
      CreateCoupon.call(self)
    end

    def update_stripe_coupon
      UpdateCoupon.call(self)
    end

    def delete_stripe_coupon
      DeleteCoupon.call(self)
    end
  end
end
