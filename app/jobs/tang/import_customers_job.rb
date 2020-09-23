module Tang
  class ImportCustomersJob < ActiveJob::Base
    queue_as :default

    def perform(starting_after = nil)
      stripe_customers = Stripe::Customer.list(limit: 100, starting_after: starting_after)
      stripe_customers.each do |stripe_customer|
        import_customer(stripe_customer)
      end
      Tang::ImportCustomersJob.perform_now(stripe_customers.data.last.id) if stripe_customers.has_more
    end

    def import_customer(stripe_customer)
      customer = Tang.customer_class.find_by(email: stripe_customer.email)
      if customer.present?
        customer = update_customer(customer, stripe_customer)

        # import card
        if stripe_customer.default_source.present?
          stripe_card = Stripe::Customer.retrieve_source(
            stripe_customer.id,
            stripe_customer.default_source,
          )
          Card.from_stripe(stripe_card, customer)
        end
      end
    end

    def update_customer(customer, stripe_customer)
      customer.stripe_id = stripe_customer.id if customer.stripe_id.nil?
      customer.coupon = Coupon.find_by(stripe_id: stripe_customer.discount.coupon.id) if stripe_customer.discount.present?
      customer.save
      return customer
    end
  end
end
