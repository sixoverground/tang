module Tang
  class InvoiceItem < ActiveRecord::Base
    belongs_to :invoice
    belongs_to :plan
    belongs_to :subscription
    has_one :customer, through: :invoice

    validates :invoice, presence: true
    validates :plan, presence: true
    validates :subscription, presence: true
    validates :stripe_id, presence: true, uniqueness: true
    validates :amount, numericality: { only_integer: true }
    validates :currency, presence: true

    def self.from_stripe(stripe_invoice_item, invoice)
      if stripe_invoice_item.plan.present?
        plan = Plan.find_by(stripe_id: stripe_invoice_item.plan.id)
      end

      if stripe_invoice_item.type == 'subscription'
        subscription = Subscription.find_by(stripe_id: stripe_invoice_item.id)
      else
        subscription = Subscription.find_by(stripe_id: stripe_invoice_item.subscription)
      end
      
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

      return invoice_item
    end
  end
end
