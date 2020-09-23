module Tang
  class DeleteCard
    def self.call(card)
      begin
        Stripe::Customer.delete_source(
          card.customer.stripe_id,
          card.stripe_id,
        )
      rescue Stripe::StripeError => e
        card.errors[:base] << e.message
      end
      return card
    end
  end
end