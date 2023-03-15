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
      return unless customer.present?

      customer = update_customer(customer, stripe_customer)

      # import card
      return unless stripe_customer.default_source.present?

      stripe_card = Stripe::Customer.retrieve_source(
        stripe_customer.id,
        stripe_customer.default_source
      )
      Card.from_stripe(stripe_card, customer)
    end

    def update_customer(customer, stripe_customer)
      customer.stripe_id = stripe_customer.id if customer.stripe_id.nil?
      if stripe_customer.discount.present?
        customer.coupon = Coupon.find_by(stripe_id: stripe_customer.discount.coupon.id)
      end
      customer.save
      customer
    end
  end
end
