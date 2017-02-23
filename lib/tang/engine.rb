require 'stripe'
require 'stripe_event'
require 'paper_trail'
require 'aasm'

module Tang
  class Engine < ::Rails::Engine
    isolate_namespace Tang

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.to_prepare do
      Rails.application.config.assets.precompile += %w( tang/pdf.css )
    end
  end
end
