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

gem 'bootstrap', '~> 4.1'
gem 'devise', '~> 4.7'
gem 'dotenv-rails', '~> 2.8', require: 'dotenv/rails-now'
gem 'pg', '~> 1.2'
gem 'puma'
gem 'rails_12factor', group: :production
gem 'rubocop', require: false
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.x'

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'cucumber-rails', '~> 2.5', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'poltergeist'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'stripe-ruby-mock', '~> 3.0.1', require: 'stripe_mock'

  # assigns is deprecated - TODO: move to request specs
  # see https://stackoverflow.com/questions/42001517/rspec-rails-controller-testing-with-assertions-and-assigns
  gem 'rails-controller-testing'
end
