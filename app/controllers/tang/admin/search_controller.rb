require_dependency 'tang/application_controller'

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
      Charge.search(@query)
    end

    def search_customers
      Customer.search(@query)
    end

    def search_plans
      plans = Plan.none
      if @query.present?
        q = "%#{@query.downcase}%"
        plans = Plan.where('lower(tang_plans.stripe_id) like ? or lower(tang_plans.name) like ?',
                           q,
                           q)
                    .distinct
      end
      plans
    end

    def search_coupons
      coupons = Coupon.none
      if @query.present?
        q = "%#{@query.downcase}%"
        coupons = Coupon.where('lower(tang_coupons.stripe_id) like ?',
                               q)
                        .distinct
      end
      coupons
    end

    def search_invoices
      Invoice.search(@query)
    end

    def search_invoice_items
      InvoiceItem.search(@query)
    end
  end
end
