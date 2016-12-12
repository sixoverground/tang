module Tang
  class ApplyCustomerDiscount
    def self.call(customer, coupon)
      if customer.stripe_id.present?
        begin
          cu = Stripe::Customer.retrieve(customer.stripe_id)
          cu.coupon = coupon.stripe_id
          cu.save

          start = cu.discount.start.to_s
          start_timestamp = DateTime.strptime(start, '%s')
          customer.update(coupon: coupon, coupon_start: start_timestamp)
        rescue Stripe::StripeError => e
          customer.errors[:base] << e.message
        end
      end

      return customer
    end
  end
end