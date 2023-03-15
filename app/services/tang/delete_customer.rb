module Tang
  class DeleteCustomer
    def self.call(customer)
      if customer.stripe_id.present?
        begin
          c = Stripe::Customer.retrieve(customer.stripe_id)
          c.delete
        rescue Stripe::StripeError => e
          customer.errors.add(:base, :invalid, message: e.message)
        end
      end
      customer
    end
  end
end
