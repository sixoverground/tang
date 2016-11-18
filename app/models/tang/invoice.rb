module Tang
  class Invoice < ActiveRecord::Base
    belongs_to :subscription
    belongs_to :customer, class_name: Tang.customer_class.to_s
    has_one :charge
    has_many :invoice_items
    belongs_to :coupon

    validates :subscription, presence: true
    validates :customer, presence: true
    validates :stripe_id, presence: true, uniqueness: true

    # scope :paid, -> { joins(:charge) }

    def period_start
      self[:period_start] || created_at
    end

    def period_end
      self[:period_end] || subscription.plan.period_days_from(period_start)
    end

    def status
      if charge.present?
        'paid'
      else
        'unpaid'
      end
    end

    def self.from_stripe(stripe_invoice)
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
        return invoice
      end
      return nil
    end
  end
end
