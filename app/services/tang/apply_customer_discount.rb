module Tang
  class ApplyCustomerDiscount
    def self.call(customer, coupon)
      if customer.stripe_id.present?
        begin
          cu = Stripe::Customer.retrieve(customer.stripe_id)
          cu.coupon = coupon.stripe_id
          cu.save
        rescue Stripe::StripeError => e
          customer.errors[:base] << e.message
        end
      end

      customer.update(coupon: coupon)

      return customer
    end
  end
end