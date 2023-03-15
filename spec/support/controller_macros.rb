module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:admin)
    end
  end

  def login_customer
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      customer = FactoryBot.create(:customer)
      # customer.confirm!
      sign_in customer
    end
  end
end

RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller
end
