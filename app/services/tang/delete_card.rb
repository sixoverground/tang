module Tang
  class DeleteCard
    def self.call(card)
      begin
        customer = Stripe::Customer.retrieve(card.customer.stripe_id)
        customer.sources.retrieve(card.stripe_id).delete
      rescue Stripe::StripeError => e
        card.errors[:base] << e.message
      end
      return card
    end
  end
end