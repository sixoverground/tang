require_dependency "tang/application_controller"

module Tang
  class Admin::CustomersController < Admin::ApplicationController
    before_action :set_customer, only: [:show, :edit, :update, :destroy]

    # GET /customers
    def index
      @customers = Tang.customer_class.where.not(stripe_id: nil).
                        paginate(page: params[:page]).
                        order(:email)
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

    def coupon
      @customer = Tang.customer_class.find(params[:customer_id])
    end

    def apply_coupon
      @customer = Tang.customer_class.find(params[:customer_id])
      @coupon = Coupon.find(params[Tang.customer_class.to_s.downcase][:coupon_id])
      ApplyCustomerDiscount.call(@customer, @coupon)
      redirect_to admin_customer_url(@customer), notice: 'Coupon was successfully applied.'
    end

    def remove_coupon
      @customer = Tang.customer_class.find(params[:customer_id])
      RemoveCustomerDiscount.call(@customer)
      redirect_to admin_customer_url(@customer), notice: 'Coupon was successfully removed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Tang.customer_class.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def customer_params
        params.require(Tang.customer_class.to_s.downcase).permit(:email, :account_balance)
      end
  end
end
