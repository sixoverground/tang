require_dependency "tang/application_controller"

module Tang
  class Admin::PaymentsController < Admin::ApplicationController
    before_action :set_payment, only: [:show]

    def index
      @payments = Charge.all.
                         paginate(page: params[:page]).
                         order(created: :desc)
    end

    def show
    end

    private
      def set_payment
        @payment = Charge.find(params[:id])
      end
  end
end
