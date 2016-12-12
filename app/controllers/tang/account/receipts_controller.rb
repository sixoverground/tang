require_dependency "tang/application_controller"

module Tang
  class Account::ReceiptsController < Account::ApplicationController
    before_action :set_receipt, only: [:show]

    def index
      @receipts = current_customer.charges.order(created: :desc)
    end

    def show
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "@receipt.stripe_id", 
                 template: 'tang/account/receipts/show.html'
        end
      end
    end

    private

    def set_receipt
      @receipt = current_customer.charges.find(params[:id])
    end
  end
end
