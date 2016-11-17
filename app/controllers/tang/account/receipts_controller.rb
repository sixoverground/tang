require_dependency "tang/application_controller"

module Tang
  class Account::ReceiptsController < Account::ApplicationController
    before_action :set_receipt, only: [:show]

    def show
    end

    private

    def set_receipt
      @receipt = current_customer.charges.find(params[:id])
    end
  end
end
