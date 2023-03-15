module Tang
  class ImportCouponsJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      # Do something later
      stripe_coupons = Stripe::Coupon.list(limit: 100, starting_after: starting_after)
      stripe_coupons.each do |stripe_coupon|
        Coupon.from_stripe(stripe_coupon)
      end

      return unless stripe_coupons.has_more

      Tang::ImportCouponsJob.perform_now(stripe_coupons.data.last.id)
    end
  end
end
