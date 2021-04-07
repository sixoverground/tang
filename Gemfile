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

ruby '2.5.8'

gem 'dotenv-rails', '~> 2.7', require: 'dotenv/rails-now'
# gem 'jquery-rails'
gem 'puma'
gem 'pg', '~> 1.2'
gem 'rails_12factor', group: :production
gem 'devise', '~> 4.7'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap', '~> 4.1'
gem 'webpacker', '~> 4.x'

group :test do
  gem 'rspec-rails', '~> 4.0.1'
  gem 'cucumber-rails', '~> 2.1', require: false
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'stripe-ruby-mock', '~> 3.0.1', require: 'stripe_mock'
  gem 'poltergeist'
  gem 'codeclimate-test-reporter', require: nil

  # assigns is deprecated - TODO: move to request specs
  # see https://stackoverflow.com/questions/42001517/rspec-rails-controller-testing-with-assertions-and-assigns
  gem 'rails-controller-testing' 
end