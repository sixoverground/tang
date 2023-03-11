require 'tang/engine'
require 'will_paginate'

module Tang
  @@customer_class = 'User'

  mattr_accessor :default_currency
  mattr_accessor :free_plan_name
  mattr_accessor :unauthorized_url
  mattr_accessor :admin_email
  mattr_accessor :plan_inheritance
  mattr_accessor :company_name
  mattr_accessor :admin_layout
  mattr_accessor :pricing_layout
  mattr_accessor :delayed_email
  mattr_accessor :admin_payment_succeeded_enabled
  mattr_accessor :admin_payment_failed_enabled

  class << self
    Tang.default_currency = 'usd'
    Tang.free_plan_name = 'Free'
    Tang.unauthorized_url = '/'
    Tang.admin_email = 'hello@tangapp.herokuapp.com'
    Tang.plan_inheritance = true
    Tang.company_name = 'Tang'
    Tang.admin_layout = 'application'
    Tang.pricing_layout = 'application'
    Tang.delayed_email = false
    Tang.admin_payment_succeeded_enabled = true
    Tang.admin_payment_failed_enabled = true
  end

  def self.setup
    yield self
  end

  def self.customer_class
    @@customer_class.constantize
  end
end
