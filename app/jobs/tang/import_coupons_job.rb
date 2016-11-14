module Tang
  class ImportCouponsJob < ActiveJob::Base
    queue_as :default

    def perform(*args)
      # Do something later
      Stripe::Coupon.list.each do |stripe_coupon|
        
        coupon = Coupon.find_or_create_by(stripe_id: stripe_coupon.id) do |c|
          c.percent_off = stripe_coupon.percent_off
          c.currency = stripe_coupon.currency
          c.amount_off = stripe_coupon.amount_off
          c.duration = stripe_coupon.duration
          c.duration_in_months = stripe_coupon.duration_in_months
          c.max_redemptions = stripe_coupon.max_redemptions
          c.redeem_by = stripe_coupon.redeem_by
        end

      end
    end
  end
end
