require "tang/engine"
# require 'jquery-rails'
# require 'bootstrap'
# require 'rails-assets-tether'
require 'will_paginate'
# require 'paranoia'

module Tang
  @@customer_class = 'User'

  class << self
    mattr_accessor :default_currency
    mattr_accessor :free_plan_name
    mattr_accessor :unauthorized_url
    mattr_accessor :admin_email
    mattr_accessor :plan_inheritance
    mattr_accessor :company_name
    mattr_accessor :admin_layout
    mattr_accessor :pricing_layout
    mattr_accessor :delayed_email

    self.default_currency = 'usd'
    self.free_plan_name = 'Free'
    self.unauthorized_url = '/'
    self.admin_email = 'hello@tangapp.herokuapp.com'
    self.plan_inheritance = true
    self.company_name = 'Tang'
    self.admin_layout = 'application'
    self.pricing_layout = 'application'
    self.delayed_email = false
  end

  def self.setup #(&block)
    yield self
  end

  def self.customer_class
    @@customer_class.constantize
  end
end
