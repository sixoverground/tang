require_dependency "tang/application_controller"

module Tang
  class Account::ReceiptsController < Account::ApplicationController
    def index
      @invoices = current_customer.invoices.
                                   paginate(page: params[:page]).
                                   order(date: :desc)
    end

    def download
      invoice = Invoice.find(params[:id])
      invoice = RefreshInvoicePdf.call(invoice)
      redirect_to invoice.invoice_pdf
    end
  end
end
