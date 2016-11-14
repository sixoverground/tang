module Tang
  class UpdateCustomer
    def self.call(customer)
      if !customer.valid?
        return customer
      end

      if customer.stripe_id.present?
        begin
          c = Stripe::Customer.retrieve(customer.stripe_id)
          c.email = customer.email
          c.account_balance = customer.account_balance if customer.account_balance.present?
          c.business_vat_id = customer.business_vat_id if customer.business_vat_id.present?
          c.description = customer.description
          if customer.coupon.present?
            c.coupon = customer.coupon.stripe_id
          end
          c.save
        rescue Stripe::StripeError => e
          customer.errors[:base] << e.message
        end
      end

      return customer
    end
  end
end