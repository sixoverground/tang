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

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.test_files = Dir["spec/**/*"]
  
  s.add_dependency "rails", "~> 4.2"
  s.add_dependency 'stripe', '~> 1.55'
  s.add_dependency 'stripe_event', '~> 1.5'
  s.add_dependency 'paper_trail', '~> 4.2'
  s.add_dependency 'jquery-rails', '~> 4.2'
  s.add_dependency 'coffee-rails', '~> 4.2'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'therubyracer', '~> 0.12'
  s.add_dependency 'uglifier', '~> 2.0' #'~> 1.3'

  s.add_development_dependency 'rails_best_practices', '~> 1.17'
end
