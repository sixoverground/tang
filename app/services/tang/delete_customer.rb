module Tang
  class DeleteCustomer
    def self.call(customer)
      if customer.stripe_id.present?
        begin
          c = Stripe::Customer.retrieve(customer.stripe_id)
          c.delete
        rescue Stripe::StripeError => e
          customer.errors[:base] << e.message
        end
      end
      return customer
    end
  end
end