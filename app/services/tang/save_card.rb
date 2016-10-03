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
        card.stripe_id = stripe_card.id
        card.address_city = stripe_card.address_city
        card.address_country = stripe_card.address_country
        card.address_line1 = stripe_card.address_line1
        card.address_line1_check = stripe_card.address_line1_check
        card.address_line2 = stripe_card.address_line2
        card.address_state = stripe_card.address_state
        card.address_zip = stripe_card.address_zip
        card.address_zip_check = stripe_card.address_zip_check
        card.brand = stripe_card.brand
        card.country = stripe_card.country
        card.cvc_check = stripe_card.cvc_check
        card.dynamic_last4 = stripe_card.dynamic_last4
        card.exp_month = stripe_card.exp_month
        card.exp_year = stripe_card.exp_year
        card.fingerprint = stripe_card.fingerprint
        card.funding = stripe_card.funding
        card.last4 = stripe_card.last4
        card.name = stripe_card.name
        card.tokenization_method = stripe_card.tokenization_method
        card.save!

      rescue Stripe::StripeError => e
        card.errors[:base] << e.message
      end
      return card
    end
  end
end