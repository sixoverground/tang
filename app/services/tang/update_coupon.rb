module Tang
  class UpdateCoupon
    def self.call(coupon)
      return coupon unless coupon.valid?

      begin
        c = Stripe::Coupon.retrieve(coupon.stripe_id)
        c.id = coupon.id
        c.save
      rescue Stripe::StripeError => e
        coupon.errors.add(:base, :invalid, message: e.message)
      end

      coupon
    end
  end
end
