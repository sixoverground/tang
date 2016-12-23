require_dependency "tang/application_controller"

module Tang
  class Admin::SearchController < Admin::ApplicationController
    def index
      @query = params[:query]

      charges = search_charges
      customers = search_customers
      plans = search_plans
      coupons = search_coupons
      invoices = search_invoices
      invoice_items = search_invoice_items

      @results = charges + customers + plans + coupons + invoices + invoice_items
    end

    private

    def search_charges
      charges = Charge.none
      if @query.present?
        q = "%#{@query.downcase}%"
        customer_table = Tang.customer_class.to_s.downcase.pluralize
        charges = Charge.joins(:customer).
            where("lower(tang_charges.stripe_id) like ? or lower(#{customer_table}.stripe_id) like ?",
                q, q).
            distinct
      end
      return charges
    end

    def search_customers
      customers = Tang.customer_class.none
      if @query.present?
        q = "%#{@query.downcase}%"
        customer_table = Tang.customer_class.to_s.downcase.pluralize
        customers = Tang.customer_class.
            joins(:subscriptions, :coupon).
            where.not(stripe_id: nil).
            where("lower(#{customer_table}.stripe_id) like ? or lower(#{customer_table}.email) like ? or lower(tang_subscriptions.stripe_id) like ? or lower(tang_coupons.stripe_id) like ?", 
                q, q, q, q).
            distinct
      end
      return customers
    end

    def search_plans
      plans = Plan.none
      if @query.present?
        q = "%#{@query.downcase}%"
        plans = Plan.where("lower(tang_plans.stripe_id) like ? or lower(tang_plans.name) like ?",
                q, q).
            distinct
      end
      return plans
    end

    def search_coupons
      coupons = Coupon.none
      if @query.present?
        q = "%#{@query.downcase}%"
        coupons = Coupon.where("lower(tang_coupons.stripe_id) like ?",
                q).
            distinct
      end
      return coupons
    end

    def search_invoices
      invoices = Invoice.none
      if @query.present?
        q = "%#{@query.downcase}%"
        customer_table = Tang.customer_class.to_s.downcase.pluralize
        invoices = Invoice.joins("left join tang_charges on tang_invoices.id = tang_charges.invoice_id").
            joins("left join tang_subscriptions on tang_subscriptions.id = tang_invoices.subscription_id").
            joins("left join #{customer_table} on #{customer_table}.id = tang_invoices.customer_id").
            where("lower(tang_charges.stripe_id) like ? or lower(tang_subscriptions.stripe_id) like ? or lower(#{customer_table}.stripe_id) like ?", 
                q, q, q).
            distinct
      end
      return invoices
    end

    def search_invoice_items
      invoice_items = InvoiceItem.none
      if @query.present?
        q = "%#{@query.downcase}%"
        customer_table = Tang.customer_class.to_s.downcase.pluralize
        invoice_items = InvoiceItem.joins(:customer, :subscription).
            where.not(description: nil).
            where("lower(tang_invoice_items.description) like ? or lower(#{customer_table}.stripe_id) like ? or lower(tang_subscriptions.stripe_id) like ?",
                q, q, q).
            distinct
      end
      return invoice_items
    end
  end
end