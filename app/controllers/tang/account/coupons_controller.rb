require_dependency "tang/application_controller"

module Tang
  class Account::CouponsController < Account::ApplicationController
    def create
      @coupon = Coupon.find_by(stripe_id: params[:coupon][:stripe_id])
      if @coupon.present?
        ApplyCustomerDiscount.call(
          current_customer,
          @coupon
        )
        redirect_to account_subscription_path, notice: 'Coupon was successfully applied.'
      else
        redirect_to account_subscription_path, notice: 'Coupon could not be applied.'
      end
    end
  end
end
