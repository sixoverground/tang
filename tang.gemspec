$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'tang/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'tang'
  s.version     = Tang::VERSION
  s.authors     = ['Craig Phares']
  s.email       = ['hello@sixoverground.com']
  s.homepage    = 'https://github.com/sixoverground/tang'
  s.summary     = 'Tang!'
  s.description = 'A Stripe subscription gem.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'aasm', '>= 4.11', '< 6.0'
  s.add_dependency 'paper_trail', '~> 12.0'
  s.add_dependency 'rails', '>= 6', '< 8'
  s.add_dependency 'stripe', '~> 5.55'
  s.add_dependency 'stripe_event', '~> 2.3'
  s.add_dependency 'will_paginate', '>= 3.1', '< 5.0'

  s.add_development_dependency 'brakeman', '~> 5.4'
  s.add_development_dependency 'rails_best_practices', '~> 1.17'
  s.metadata['rubygems_mfa_required'] = 'true'
end
