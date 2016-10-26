require "tang/engine"

module Tang
  class << self
    mattr_accessor :default_currency
    mattr_accessor :customer_class
    mattr_accessor :free_plan_name
    # mattr_accessor :unauthorized_url
    mattr_accessor :admin_email

    self.default_currency = 'usd'
    self.customer_class = 'User'
    self.free_plan_name = 'Free Plan'
    # self.unauthorized_url = '/'
    self.admin_email = 'hello@tangapp.herokuapp.com'
  end

  def self.setup #(&block)
    yield self
  end
end
