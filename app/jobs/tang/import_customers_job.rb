module Tang
  class ImportCustomersJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      # Do something later
      stripe_customers = Stripe::Customer.list(limit: 100, starting_after: starting_after)
      stripe_customers.each do |stripe_customer|
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

      if stripe_customers.has_more
        Tang::ImportCustomersJob.perform_now(stripe_customers.data.last.id)
      end
    end
  end
end
