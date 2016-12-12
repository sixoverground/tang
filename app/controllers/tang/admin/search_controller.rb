require_dependency "tang/application_controller"

module Tang
  class Admin::SearchController < Admin::ApplicationController
    def index
      @query = params[:query]
      q = "%#{@query.downcase}%"
      customer_table = Tang.customer_class.to_s.downcase.pluralize

      charges = Charge.none
      customers = Tang.customer_class.none
      plans = Plan.none
      coupons = Coupon.none
      invoices = Invoice.none
      invoice_items = InvoiceItem.none

      if @query.present?
        charges = Charge.joins(:customer).
                    where("lower(tang_charges.stripe_id) like ? or lower(#{customer_table}.stripe_id) like ?",
                      q, q).
                    distinct

        customers = Tang.customer_class.
                      joins(:subscriptions, :coupon).
                      where.not(stripe_id: nil).
                      where("lower(#{customer_table}.stripe_id) like ? or lower(#{customer_table}.email) like ? or lower(tang_subscriptions.stripe_id) like ? or lower(tang_coupons.stripe_id) like ?", 
                        q, q, q, q).
                      distinct

        plans = Plan.where("lower(tang_plans.stripe_id) like ? or lower(tang_plans.name) like ?",
                    q, q).
                  distinct

        coupons = Coupon.where("lower(tang_coupons.stripe_id) like ?",
                      q).
                    distinct

        invoices = Invoice.joins("left join tang_charges on tang_invoices.id = tang_charges.invoice_id").
                     joins("left join tang_subscriptions on tang_subscriptions.id = tang_invoices.subscription_id").
                     joins("left join #{customer_table} on #{customer_table}.id = tang_invoices.customer_id").
                     where("lower(tang_charges.stripe_id) like ? or lower(tang_subscriptions.stripe_id) like ? or lower(#{customer_table}.stripe_id) like ?", 
                       q, q, q).
                     distinct

        invoice_items = InvoiceItem.joins(:customer, :subscription).
                          where.not(description: nil).
                          where("lower(tang_invoice_items.description) like ? or lower(#{customer_table}.stripe_id) like ? or lower(tang_subscriptions.stripe_id) like ?",
                            q, q, q).
                          distinct
      end

      @results = charges + customers + plans + coupons + invoices + invoice_items
    end
  end
end