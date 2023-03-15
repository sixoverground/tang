class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_paper_trail_whodunnit

  def ensure_plan!(plan)
    return if current_user.subscribed_to? plan

    redirect_to '/', alert: 'You do not have access to that.'
  end
end
