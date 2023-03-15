module Tang
  class UpdateCustomer
    def self.call(customer)
      return customer unless customer.valid?

      if customer.stripe_id.present?
        begin
          c = Stripe::Customer.retrieve(customer.stripe_id)
          c = populate_customer(c, customer)
          c.save
        rescue Stripe::StripeError => e
          customer.errors.add(:base, :invalid, message: e.message)
        end
      end

      customer
    end

    def self.populate_customer(stripe_customer, customer)
      stripe_customer.email = customer.email
      stripe_customer.account_balance = customer.account_balance if customer.account_balance.present?
      stripe_customer.business_vat_id = customer.business_vat_id if customer.business_vat_id.present?
      stripe_customer.description = customer.description
      stripe_customer.coupon = customer.coupon.stripe_id if customer.coupon.present?
      stripe_customer
    end
  end
end
