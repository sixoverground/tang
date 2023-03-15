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
      plan = Plan.find_by(stripe_id: stripe_invoice_item.plan.id) if stripe_invoice_item.plan.present?

      subscription = if stripe_invoice_item.type == 'subscription'
                       Subscription.find_by(stripe_id: stripe_invoice_item.id)
                     else
                       Subscription.find_by(stripe_id: stripe_invoice_item.subscription)
                     end

      InvoiceItem.find_or_create_by(stripe_id: stripe_invoice_item.id, invoice: invoice) do |ii|
        ii.amount = stripe_invoice_item.amount
        ii.currency = stripe_invoice_item.currency

        ii.period_start = DateTime.strptime(stripe_invoice_item.period.start.to_s, '%s')
        ii.period_end = DateTime.strptime(stripe_invoice_item.period.end.to_s, '%s')

        ii.plan = plan
        ii.proration = stripe_invoice_item.proration
        ii.quantity = stripe_invoice_item.quantity
        ii.subscription = subscription
        ii.description = stripe_invoice_item.description
      end
    end

    def self.search(query)
      invoice_items = InvoiceItem.none
      if query.present?
        q = "%#{query.downcase}%"
        customer_table = connection.quote_table_name(Customer.table_name)
        invoice_items = InvoiceItem.joins(:customer, :subscription)
                                   .where.not(description: nil)
                                   .where(
                                     "lower(tang_invoice_items.description) like ? or lower(#{customer_table}.stripe_id) like ? or lower(tang_subscriptions.stripe_id) like ?",
                                     q, q, q
                                   )
                                   .distinct
      end
      invoice_items
    end
  end
end
