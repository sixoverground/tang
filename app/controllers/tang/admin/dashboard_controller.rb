require_dependency "tang/application_controller"

module Tang
  class Admin::DashboardController < Admin::ApplicationController
    def index
      @total_customers = Tang.customer_class.where.not(stripe_id: nil).count
      @total_volume = Charge.sum(:amount) / 100
    end
  end
end
