module Tang
  class InvoiceItem < ActiveRecord::Base
    belongs_to :invoice
    belongs_to :plan
    belongs_to :subscription

    def self.from_stripe(stripe_invoice_item, invoice)
      if stripe_invoice_item.plan.present?
        plan = Plan.find_by(stripe_id: stripe_invoice_item.plan.id)
      end
      ii_subscription = Subscription.find_by(stripe_id: stripe_invoice_item.subscription)
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
        ii.subscription = ii_subscription
        ii.description = stripe_invoice_item.description
      end
      return invoice_item
    end
  end
end
