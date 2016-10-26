module Tang
  class Admin::ApplicationController < ApplicationController
    before_action :ensure_admin

    def ensure_admin
      authenticate_user! if self.respond_to?(:authenticate_user!)
      unless current_user.present? && current_user.respond_to?(:admin?) && current_user.admin?
        redirect_to unauthorized_url, alert: 'You do not have access to that.'
      end
    end
  end
end
