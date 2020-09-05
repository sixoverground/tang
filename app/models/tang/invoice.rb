module Tang
  class Invoice < ActiveRecord::Base
    belongs_to :subscription
    belongs_to :customer, class_name: Tang.customer_class.to_s
    has_many :charges, dependent: :destroy
    has_many :invoice_items, dependent: :destroy
    belongs_to :coupon, optional: true

    validates :customer, presence: true
    validates :stripe_id, presence: true, uniqueness: true

    # scope :paid, -> { joins(:charge) }

    def charge
      self.charges.order(:created_at).last
    end

    def period_start
      self[:period_start] || created_at
    end

    def period_end
      if subscription.present?
        self[:period_end] || subscription.plan.period_days_from(period_start)
      else
        self.period_start
      end
    end

    def status
      if charge.present?
        'paid'
      else
        'unpaid'
      end
    end

    def self.from_stripe(stripe_invoice)
      customer = Tang.customer_class.find_by(stripe_id: stripe_invoice.customer)
      subscription = Subscription.find_by(stripe_id: stripe_invoice.subscription)
      invoice = Invoice.find_or_create_by(stripe_id: stripe_invoice.id) do |i|
        i.subscription = subscription
        i.customer = customer
        i.period_start = stripe_invoice.period_start
        i.period_end = stripe_invoice.period_end
        i.date = stripe_invoice.date
        i.currency = stripe_invoice.currency
        i.subtotal = stripe_invoice.subtotal
        i.tax_percent = stripe_invoice.tax_percent
        i.tax = stripe_invoice.tax
        i.total = stripe_invoice.total
        i.amount_due = stripe_invoice.amount_due
        i.invoice_pdf = stripe_invoice.invoice_pdf

        if stripe_invoice.discount.present?
          # coupon = Coupon.from_stripe(stripe_invoice.discount.coupon)
          coupon = Coupon.find_by(stripe_id: stripe_invoice.discount.coupon.id)
          i.coupon = coupon
        end
      
      end
      return invoice
    end

    def self.search(query)
      invoices = Invoice.none
      if query.present?
        q = "%#{query.downcase}%"
        customer_table = connection.quote_table_name(Customer.table_name)
        invoices = Invoice.joins("left join tang_charges on tang_invoices.id = tang_charges.invoice_id").
            joins("left join tang_subscriptions on tang_subscriptions.id = tang_invoices.subscription_id").
            joins("left join #{customer_table} on #{customer_table}.id = tang_invoices.customer_id").
            where("lower(tang_charges.stripe_id) like ? or lower(tang_subscriptions.stripe_id) like ? or lower(#{customer_table}.stripe_id) like ?", 
                q, q, q).
            distinct
      end
      return invoices
    end
  end
end
