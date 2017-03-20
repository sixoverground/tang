module Tang
  class ImportCouponsJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Coupon.list.each do |stripe_coupon|
        Coupon.from_stripe(stripe_coupon)
      end
    end
  end
end
