puts "config/initializers/stripe.rb called"
Stripe.api_key = ENV['STRIPE_SECRET_KEY']