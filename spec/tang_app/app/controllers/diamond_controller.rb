class DiamondController < ApplicationController
  before_action :authenticate_user!
  before_action -> { ensure_plan!('diamond') }

  def index
  end
end
