module Tang
  class UpdateCoupon
    def self.call(coupon)
      if !coupon.valid?
        return coupon
      end

      begin
        c = Stripe::Coupon.retrieve(coupon.stripe_id)
        c.id = coupon.id
        c.save
      rescue Stripe::StripeError => e
        coupon.errors[:base] << e.message
      end

      return coupon
    end
  end
end