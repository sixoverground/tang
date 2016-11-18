module Tang
  class ImportCustomersJob < ActiveJob::Base
    queue_as :default

    def perform
      # Do something later
      Stripe::Customer.list.each do |stripe_customer|
        customer = Tang.customer_class.find_by(email: stripe_customer.email)
        if customer.present?
          customer.stripe_id = stripe_customer.id
          customer.coupon = Coupon.find_by(stripe_id: stripe_customer.discount.coupon.id) if stripe_customer.discount.present?
          customer.save

          # import card
          if stripe_customer.default_source.present?
            stripe_card = stripe_customer.sources.retrieve(stripe_customer.default_source)
            card = Card.find_or_create_by(stripe_id: stripe_card.id) do |c|
              c.customer = customer
              c.address_city = stripe_card.address_city
              c.address_country = stripe_card.address_country
              c.address_line1 = stripe_card.address_line1
              c.address_line1_check = stripe_card.address_line1_check
              c.address_line2 = stripe_card.address_line2
              c.address_state = stripe_card.address_state
              c.address_zip = stripe_card.address_zip
              c.address_zip_check = stripe_card.address_zip_check
              c.brand = stripe_card.brand
              c.country = stripe_card.country
              c.cvc_check = stripe_card.cvc_check
              c.dynamic_last4 = stripe_card.dynamic_last4
              c.exp_month = stripe_card.exp_month
              c.exp_year = stripe_card.exp_year
              c.funding = stripe_card.funding
              c.last4 = stripe_card.last4
              c.name = stripe_card.name
              c.tokenization_method = stripe_card.tokenization_method
            end
          end
        end
      end
    end
  end
end
