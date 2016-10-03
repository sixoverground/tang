require_dependency "tang/application_controller"

module Tang
  class Admin::CustomersController < Admin::ApplicationController
    before_action :set_customer, only: [:show, :edit, :update, :destroy]

    # GET /customers
    def index
      @customers = User.order(:email)
    end

    # GET /customers/1
    def show
    end

    # GET /customers/1/edit
    def edit
    end

    # PATCH/PUT /customers/1
    def update
      if @customer.update(customer_params)
        redirect_to admin_customer_path(@customer), notice: 'Customer was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /customers/1
    def destroy
      @customer.destroy
      redirect_to admin_customers_url, notice: 'Customer was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def customer_params
        params.require(:user).permit(:email, :account_balance, :business_vat_id, :description)
      end
  end
end
