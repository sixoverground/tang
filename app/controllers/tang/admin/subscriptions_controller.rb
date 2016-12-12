require_dependency "tang/application_controller"

module Tang
  class Admin::SubscriptionsController < Admin::ApplicationController
    before_action :set_subscription, only: [:show, :edit, :update, :destroy]

    # GET /subscriptions
    def index
      @subscriptions = Subscription.includes(:customer).
                                    where.not(status: :canceled).
                                    paginate(page: params[:page]).
                                    order("#{Tang.customer_class.to_s.downcase.pluralize}.email")
    end

    # GET /subscriptions/1
    def show
    end

    # GET /subscriptions/1/edit
    def edit
    end

    # PATCH/PUT /subscriptions/1
    def update
      @subscription.end_trial_now = (params[:subscription][:end_trial_now] == '1')
      if @subscription.end_trial_now
        params[:subscription]['trial_end(1i)'] = ''
        params[:subscription]['trial_end(2i)'] = ''
        params[:subscription]['trial_end(3i)'] = ''
      end

      if @subscription.update(subscription_params)
        redirect_to [:admin, @subscription], notice: 'Subscription was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /subscriptions/1
    def destroy
      @subscription.cancel!
      redirect_to admin_subscriptions_url, notice: 'Subscription was successfully canceled.'
    end

    def coupon
      @subscription = Subscription.find(params[:subscription_id])
    end

    def apply_coupon
      @subscription = Subscription.find(params[:subscription_id])
      @coupon = Coupon.find(params[:subscription][:coupon_id])
      ApplySubscriptionDiscount.call(@subscription, @coupon)
      redirect_to admin_subscription_url(@subscription), notice: 'Coupon was successfully applied.'
    end

    def remove_coupon
      @subscription = Subscription.find(params[:subscription_id])
      RemoveSubscriptionDiscount.call(@subscription)
      redirect_to admin_subscription_url(@subscription), notice: 'Coupon was successfully removed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_subscription
        @subscription = Subscription.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def subscription_params
        params.require(:subscription).permit(:plan_id, :quantity, :trial_end, :tax_percent)
      end
  end
end
