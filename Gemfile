source 'https://rubygems.org'

# Declare your gem's dependencies in tang.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

ruby '2.3.1'

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'rails_12factor', group: :production
gem 'puma'
gem 'pg'
gem 'devise'
gem 'cancancan'
gem 'jquery-rails'

group :test do
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'stripe-ruby-mock', '~> 2.3.1', require: 'stripe_mock'
  # gem 'selenium-webdriver'
  gem 'poltergeist'
  gem "codeclimate-test-reporter", require: nil
end