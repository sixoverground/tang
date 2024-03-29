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
      charges.order(:created_at).last
    end

    def period_start
      self[:period_start] || created_at
    end

    def period_start=(val)
      self[:period_start] = val
    end

    def period_end
      if subscription.present?
        self[:period_end] || subscription.plan.period_days_from(period_start)
      else
        period_start
      end
    end

    def period_end=(val)
      self[:period_end] = val
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
        i.period_start = DateTime.strptime(stripe_invoice.period_start.to_s, '%s')
        i.period_end = DateTime.strptime(stripe_invoice.period_end.to_s, '%s')
        i.date = DateTime.strptime(stripe_invoice.created.to_s, '%s') # changed from date
        i.currency = stripe_invoice.currency
        i.subtotal = stripe_invoice.subtotal
        # i.tax_percent = stripe_invoice.tax_percent # removed from api, replaced with tax rates
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

      invoice.save if invoice.update_from_stripe(stripe_invoice)
      invoice
    end

    def update_from_stripe(stripe_invoice)
      changed = false

      stripe_period_start = DateTime.strptime(stripe_invoice.period_start.to_s, '%s')
      if self[:period_start] != stripe_period_start
        self.period_start = stripe_period_start
        changed = true
      end

      stripe_period_end = DateTime.strptime(stripe_invoice.period_end.to_s, '%s')
      if self[:period_end] != stripe_period_end
        self.period_end = stripe_period_end
        changed = true
      end

      stripe_created = DateTime.strptime(stripe_invoice.created.to_s, '%s')
      if date != stripe_created
        self.date = stripe_created
        changed = true
      end

      if invoice_pdf != stripe_invoice.invoice_pdf
        self.invoice_pdf = stripe_invoice.invoice_pdf
        changed = true
      end

      changed
    end

    def self.search(query)
      invoices = Invoice.none
      if query.present?
        q = "%#{query.downcase}%"
        customer_table = connection.quote_table_name(Customer.table_name)
        invoices = Invoice.joins('left join tang_charges on tang_invoices.id = tang_charges.invoice_id')
                          .joins('left join tang_subscriptions on tang_subscriptions.id = tang_invoices.subscription_id')
                          .joins("left join #{customer_table} on #{customer_table}.id = tang_invoices.customer_id")
                          .where(
                            "lower(tang_charges.stripe_id) like ? or lower(tang_subscriptions.stripe_id) like ? or lower(#{customer_table}.stripe_id) like ?",
                            q, q, q
                          )
                          .distinct
      end
      invoices
    end
  end
end
