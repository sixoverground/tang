require_dependency "tang/application_controller"

module Tang
  class Account::SubscriptionsController < Account::ApplicationController
    before_action :set_subscription, only: [:show, :edit, :update, :destroy]

    def show
      @plans = Plan.order(:order)

      if @subscription.present? && @subscription.plan.present?
        @next_plan = @plans.where("tang_plans.order > ?", @subscription.plan.order).first
        @previous_plan = @plans.where("tang_plans.order < ?", @subscription.plan.order).last
      else
        @next_plan = @plans.first
        @previous_plan = nil
      end

      @receipts = current_customer.charges.order(created: :desc).limit(5)
    end

    def new
      plan = Plan.find(params[:plan])
      @subscription = Subscription.new(
        plan: plan,
        customer: current_customer
      )
    end

    def create
      plan = Plan.find(subscription_params[:plan])
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
      plan = Plan.find(params[:plan])
      @subscription = ChangeSubscription.call(
        @subscription,
        plan
      )
      if @subscription.errors.blank?
        redirect_to account_subscription_path, notice: 'Subscription was successfully changed.'
      else
        @plans = Plan.order(:order)
        @next_plan = @plans.where("tang_plans.order > ?", @subscription.plan.order).first
        @previous_plan = @plans.where("tang_plans.order < ?", @subscription.plan.order).last
        render :show
      end
    end

    def destroy
      # @subscription.destroy
      @subscription.cancel!
      redirect_to account_subscription_path, notice: 'Subscription was successfully cancelled.'
    end

    private

    def set_subscription
      @subscription = current_customer.subscription
    end

    def subscription_params
      params.require(:subscription).permit(:plan)
    end

    # def subscription_update_params
    #   params.permit(:plan)
    # end
  end
end
