module Tang
  class Account::ApplicationController < ApplicationController
    before_action :ensure_customer

    def ensure_customer
      authenticate_user! if respond_to?(:authenticate_user!)
      @current_customer = current_user
    end

    attr_reader :current_customer
  end
end
