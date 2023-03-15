module Tang
  class Admin::ApplicationController < ApplicationController
    before_action :ensure_admin

    layout Tang.admin_layout

    def ensure_admin
      authenticate_user! if respond_to?(:authenticate_user!)
      return if current_user.present? && current_user.respond_to?(:admin?) && current_user.admin?

      redirect_to Tang.unauthorized_url, alert: 'You do not have access to that.'
    end
  end
end
