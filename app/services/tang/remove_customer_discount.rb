module Tang
  class RemoveCustomerDiscount
    def self.call(customer)
      begin
        cu = Stripe::Customer.retrieve(customer.stripe_id)
        cu.delete_discount
      rescue Stripe::StripeError => e
        customer.errors[:base] << e.message
      end

      customer.update(coupon: nil)

      return customer
    end
  end
end