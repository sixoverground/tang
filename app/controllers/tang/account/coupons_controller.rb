require_dependency "tang/application_controller"

module Tang
  class Account::CouponsController < Account::ApplicationController
    def create
      @coupon = Coupon.find_by(stripe_id: params[:coupon][:stripe_id])
      if @coupon.present?
        if current_customer.subscription.present?
          ApplySubscriptionDiscount.call(
            current_customer.subscription,
            @coupon
          )
        else
          current_customer.subscription_coupon = @coupon
          current_customer.save
        end
        redirect_to account_subscription_path, notice: 'Coupon was successfully applied.'
      else
        redirect_to account_subscription_path, alert: 'Coupon could not be applied.'
      end
    end
  end
end
