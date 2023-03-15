require_dependency 'tang/application_controller'

module Tang
  class Admin::CouponsController < Admin::ApplicationController
    before_action :set_coupon, only: [:show, :destroy]

    # GET /coupons
    def index
      @coupons = Coupon.all
                       .paginate(page: params[:page])
                       .order(:stripe_id)
    end

    # GET /coupons/1
    def show; end

    # GET /coupons/new
    def new
      @coupon = Coupon.new
    end

    # POST /coupons
    def create
      @coupon = Coupon.new(coupon_params)

      if @coupon.save
        redirect_to [:admin, @coupon], notice: 'Coupon was successfully created.'
      else
        render :new
      end
    end

    # DELETE /coupons/1
    def destroy
      @coupon.destroy
      redirect_to admin_coupons_url, notice: 'Coupon was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coupon_params
      params.require(:coupon)
            .permit(
              :stripe_id, :duration, :amount_off, :currency,
              :duration_in_months, :max_redemptions, :percent_off, :redeem_by
            )
    end
  end
end
