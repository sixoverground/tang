$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tang/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tang"
  s.version     = Tang::VERSION
  s.authors     = ["Craig Phares"]
  s.email       = ["hello@sixoverground.com"]
  s.homepage    = "https://github.com/sixoverground/tang"
  s.summary     = "Tang!"
  s.description = "A Stripe subscription gem."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.test_files = Dir["spec/**/*"]
  
  s.add_dependency "rails", "~> 4.2.7.1"
  s.add_dependency 'stripe'
  s.add_dependency 'stripe_event'
  s.add_dependency 'paper_trail'

  # s.add_development_dependency "pg"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'dotenv-rails'
  s.add_development_dependency 'rails_best_practices'
end
