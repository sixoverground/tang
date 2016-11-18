puts "config/initializers/stripe.rb called: #{ENV['STRIPE_SECRET_KEY']}"
Stripe.api_key = ENV['STRIPE_SECRET_KEY']