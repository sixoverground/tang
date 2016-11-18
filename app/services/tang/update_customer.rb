module Tang
  class UpdateCustomer
    def self.call(customer)
      return customer if !customer.valid?

      if customer.stripe_id.present?
        begin
          c = Stripe::Customer.retrieve(customer.stripe_id)
          c.email = customer.email
          c.account_balance = customer.account_balance if customer.account_balance.present?
          c.business_vat_id = customer.business_vat_id if customer.business_vat_id.present?
          c.description = customer.description
          c.coupon = customer.coupon.stripe_id if customer.coupon.present?
          c.save
        rescue Stripe::StripeError => e
          customer.errors[:base] << e.message
        end
      end

      return customer
    end
  end
end