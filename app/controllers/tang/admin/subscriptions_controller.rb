require_dependency "tang/application_controller"

module Tang
  class Admin::SubscriptionsController < Admin::ApplicationController
    before_action :set_subscription, only: [:show, :edit, :update, :destroy]

    # GET /subscriptions
    def index
      @subscriptions = Subscription.all
    end

    # GET /subscriptions/1
    def show
    end

    # GET /subscriptions/1/edit
    def edit
    end

    # PATCH/PUT /subscriptions/1
    def update
      plan = Plan.find(subscription_params[:plan_id])
      @subscription = SubscriptionService.new.update(
        @subscription,
        plan
      )
      if @subscription.errors.blank?
        redirect_to [:admin, @subscription], notice: 'Subscription was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /subscriptions/1
    def destroy
      @subscription.destroy
      redirect_to admin_subscriptions_url, notice: 'Subscription was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_subscription
        @subscription = Subscription.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def subscription_params
        params.require(:subscription).permit(:plan_id)
      end
  end
end
