module Tang
  class CreateCoupon
    def self.call(coupon)
      return coupon unless coupon.valid?

      begin
        Stripe::Coupon.create(
          id: coupon.stripe_id,
          duration: coupon.duration,
          percent_off: coupon.percent_off,
          duration_in_months: coupon.duration_in_months,
          amount_off: coupon.amount_off,
          currency: coupon.currency,
          max_redemptions: coupon.max_redemptions,
          redeem_by: (coupon.redeem_by.present? ? coupon.redeem_by.to_i : nil)
        )
      rescue Stripe::StripeError => e
        coupon.errors.add(:base, :invalid, message: e.message)
        return coupon
      end

      coupon
    end
  end
end
