require_dependency "tang/application_controller"

module Tang
  class Admin::InvoicesController < Admin::ApplicationController
    before_action :set_invoice, only: [:show]

    def index
      @invoices = Invoice.all
    end

    def show
    end

    private
      def set_invoice
        @invoice = Invoice.find(params[:id])
      end
  end
end
