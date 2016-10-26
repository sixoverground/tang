require_dependency "tang/application_controller"

module Tang
  class Account::SubscriptionsController < Account::ApplicationController
    before_action :set_subscription, only: [:show, :edit, :update, :destroy]

    def show
      @plans = Plan.order(:order)

      if @subscription.present?
        @next_plan = @plans.where("tang_plans.order > ?", @subscription.plan.order).first
      else
        @next_plan = @plans.first
      end
    end

    def new
      plan = Plan.find(params[:plan])
      @subscription = Subscription.new(
        plan: plan,
        customer: current_customer
      )
    end

    def create
      puts "params: #{params}"
      plan = Plan.find(subscription_create_params[:plan])
      @subscription = CreateSubscription.call(
        plan,
        current_customer,
        params[:stripe_token]
      )

      if @subscription.errors.blank?
        redirect_to account_subscription_path, notice: 'Subscription was successfully created.'
      else
        render :new
      end
    end

    def update
      plan = Plan.find(subscription_update_params[:plan])
      @subscription = ChangeSubscription.call(
        @subscription,
        plan
      )
      if @subscription.errors.blank?
        redirect_to account_subscription_path, notice: 'Subscription was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @subscription.destroy
      redirect_to account_subscription_path, notice: 'Subscription was successfully destroyed.'
    end

    private

    def set_subscription
      @subscription = current_customer.subscription
    end

    def subscription_create_params
      params.require(:subscription).permit(:plan)
    end

    def subscription_update_params
      params.permit(:plan)
    end
  end
end
