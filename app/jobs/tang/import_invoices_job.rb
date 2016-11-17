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
            i.customer = subscription.customer
            i.period_start = stripe_invoice.period_start
            i.period_end = stripe_invoice.period_end
            i.date = stripe_invoice.date
            i.currency = stripe_invoice.currency
            i.subtotal = stripe_invoice.subtotal
            i.tax_percent = stripe_invoice.tax_percent
            i.tax = stripe_invoice.tax
            i.total = stripe_invoice.total
            i.amount_due = stripe_invoice.amount_due

            if stripe_invoice.discount.present?
              coupon = Coupon.find_by(stripe_id: stripe_invoice.discount.coupon.id)
              i.coupon = coupon
            end
          end

          stripe_invoice.lines.data.each do |stripe_invoice_item|
            if stripe_invoice_item.plan.present?
              plan = Plan.find_by(stripe_id: stripe_invoice_item.plan.id)
            end
            subscription = Subscription.find_by(stripe_id: stripe_invoice_item.subscription)

            invoice_item = InvoiceItem.find_or_create_by(stripe_id: stripe_invoice_item.id, invoice: invoice) do |ii|
              ii.amount = stripe_invoice_item.amount
              ii.currency = stripe_invoice_item.currency

              period_start = stripe_invoice_item.period.start.to_s
              ii.period_start = DateTime.strptime(period_start, '%s')
              period_end = stripe_invoice_item.period.end.to_s
              ii.period_end = DateTime.strptime(period_end, '%s')
              
              ii.plan = plan
              ii.proration = stripe_invoice_item.proration
              ii.quantity = stripe_invoice_item.quantity
              ii.subscription = subscription
              ii.description = stripe_invoice_item.description
            end
          end

        end

      end
    end
  end
end
