module Tang
  class Coupon < ActiveRecord::Base
    has_paper_trail

    has_many :customers, class_name: Tang.customer_class.to_s
    has_many :subscriptions

    before_create :create_stripe_coupon
    before_update :update_stripe_coupon
    before_destroy :delete_stripe_coupon

    DURATIONS = ['once', 'repeating', 'forever']

    def coupon_valid?
      # check if expired
      if self.redeem_by.present?
        false if Time.now > self.redeem_by
      end

      if self.max_redemptions.present?
        # check if any discounts created
      end

      true
    end

    def formatted_duration
      if duration == 'repeating'
        "for #{duration_in_months} months"
      else
        duration
      end
    end

    def active_redemptions
      Tang.customer_class.
           joins(:subscription).
           where("#{Tang.customer_class.to_s.downcase.pluralize}.coupon_id = ? OR tang_subscriptions.coupon_id = ?", self.id, self.id).
           uniq
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
