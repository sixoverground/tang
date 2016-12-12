require_dependency "tang/application_controller"

module Tang
  class Admin::PlansController < Admin::ApplicationController
    before_action :set_plan, only: [:show, :edit, :update, :destroy]

    # GET /plans
    def index
      @plans = Plan.all.
                    paginate(page: params[:page]).
                    order(:name)
    end

    # GET /plans/1
    def show
    end

    # GET /plans/new
    def new
      @plan = Plan.new
    end

    # GET /plans/1/edit
    def edit
    end

    # POST /plans
    def create
      @plan = Plan.new(plan_create_params)

      if @plan.save
        redirect_to [:admin, @plan], notice: 'Plan was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /plans/1
    def update
      if @plan.update(plan_update_params)
        redirect_to [:admin, @plan], notice: 'Plan was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /plans/1
    def destroy
      @plan.destroy
      redirect_to admin_plans_url, notice: 'Plan was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_plan
        @plan = Plan.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def plan_create_params
        params.require(:plan).permit(:stripe_id, :amount, :currency, :interval, :interval_count, :name, :statement_descriptor, :trial_period_days)
      end

      def plan_update_params
        params.require(:plan).permit(:name)
      end
  end
end
