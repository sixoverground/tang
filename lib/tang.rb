require "tang/engine"
require 'bootstrap'
require 'rails-assets-tether'

module Tang
  @@customer_class = 'User'

  class << self
    mattr_accessor :default_currency
    mattr_accessor :free_plan_name
    mattr_accessor :unauthorized_url
    mattr_accessor :admin_email
    mattr_accessor :plan_inheritance
    mattr_accessor :company_name

    self.default_currency = 'usd'
    self.free_plan_name = 'Free Plan'
    self.unauthorized_url = '/'
    self.admin_email = 'hello@tangapp.herokuapp.com'
    self.plan_inheritance = true
    self.company_name = 'Tang'
  end

  def self.setup #(&block)
    yield self
  end

  def self.customer_class
    @@customer_class.constantize
  end
end
