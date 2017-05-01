require_dependency "tang/application_controller"

module Tang
  class PlansController < ApplicationController
    layout Tang.pricing_layout

    def index
      @plans = Plan.all.order(:order)
    end
  end
end
