require_dependency "tang/application_controller"

module Tang
  class Account::ReceiptsController < Account::ApplicationController
    def index
      @invoices = current_customer.invoices.
                                   paginate(page: params[:page]).
                                   order(period_start: :desc)
    end
  end
end
