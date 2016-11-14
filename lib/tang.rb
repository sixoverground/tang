require "tang/engine"

module Tang
  @@customer_class = 'User'

  class << self
    mattr_accessor :default_currency
    mattr_accessor :free_plan_name
    mattr_accessor :unauthorized_url
    mattr_accessor :admin_email
    mattr_accessor :plan_inheritance

    self.default_currency = 'usd'
    self.free_plan_name = 'Free Plan'
    self.unauthorized_url = '/'
    self.admin_email = 'hello@tangapp.herokuapp.com'
    self.plan_inheritance = true
  end

  def self.setup #(&block)
    yield self
  end

  def self.customer_class
    @@customer_class.constantize
  end
end
