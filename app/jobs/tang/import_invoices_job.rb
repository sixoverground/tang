module Tang
  class ImportInvoicesJob < ActiveJob::Base
    queue_as :default

    def perform(*args)
      # Do something later
      Stripe::Invoice.list.each do |stripe_invoice|

        subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)
        
        if subscription.present?
          invoice = Invoice.find_or_create_by(stripe_id: stripe_invoice.id) do |i|
            i.subscription = subscription
            i.period_start = stripe_invoice.period_start
            i.period_end = stripe_invoice.period_end
            i.date = stripe_invoice.date
            i.total = stripe_invoice.total
            i.currency = stripe_invoice.currency
          end
        end

      end
    end
  end
end
