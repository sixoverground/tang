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
            Card.from_stripe(stripe_card, customer)
          end
        end
      end
    end
  end
end
