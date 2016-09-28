Tang::Engine.routes.draw do
  mount StripeEvent::Engine, at: '/stripe_event'
  resources :plans
end
