module Tang
  class DeleteCoupon
    def self.call(coupon)
      begin
        c = Stripe::Coupon.retrieve(coupon.stripe_id)
        c.delete        
      rescue Stripe::StripeError => e
        coupon.errors.add(:base, :invalid, message: e.message)
      end
      return coupon
    end
  end
end