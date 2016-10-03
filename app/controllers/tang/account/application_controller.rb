module Tang
  class Account::ApplicationController < ApplicationController
    before_action :authenticate_user!

    def current_customer
      @current_customer ||= current_user
    end
  end
end
