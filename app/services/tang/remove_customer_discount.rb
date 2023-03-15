module Tang
  class RemoveCustomerDiscount
    def self.call(customer)
      begin
        cu = Stripe::Customer.retrieve(customer.stripe_id)
        cu.delete_discount
      rescue Stripe::StripeError => e
        customer.errors.add(:base, :invalid, message: e.message)
      end

      customer.update(coupon: nil, coupon_start: nil)

      customer
    end
  end
end
