Stripe.api_key = ENV.fetch('STRIPE_SECRET_KEY', nil)
StripeEvent.signing_secret = ENV.fetch('STRIPE_SIGNING_SECRET', nil)
