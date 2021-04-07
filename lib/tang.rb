require "tang/engine"
# require 'jquery-rails'
# require 'bootstrap'
# require 'rails-assets-tether'
require 'will_paginate'
# require 'paranoia'

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
  end

  def self.setup #(&block)
    yield self
  end

  def self.customer_class
    @@customer_class.constantize
  end
end
