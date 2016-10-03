module Tang
  class SaveCard
    def self.call(customer, token)
      if customer.card.present?
        card = customer.card
      else
        card = Card.new(customer: customer)
      end

      begin
        if customer.stripe_id.present?
          cu = Stripe::Customer.retrieve(customer.stripe_id)
          cu.source = token
          cu.save
        else
          cu = Stripe::Customer.create(
            source: token,
            email: customer.email
          )
          customer.stripe_id = cu.id
          customer.save!
        end

        # Save the payment method
        stripe_card = cu.sources.retrieve(cu.default_source)
        card.update_from_stripe(stripe_card)

      rescue Stripe::StripeError => e
        card.errors[:base] << e.message
      end
      return card
    end
  end
end