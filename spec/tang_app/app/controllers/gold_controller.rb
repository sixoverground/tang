class GoldController < ApplicationController
  before_action :authenticate_user!
  before_action -> { ensure_plan!('gold') }

  def index; end
end
