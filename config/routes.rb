Tang::Engine.routes.draw do
  namespace :account do
  get 'subscriptions_controller/show'
  end

  mount StripeEvent::Engine, at: '/stripe_event'

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :subscriptions, only: [:index, :show, :edit, :update, :destroy]
    resources :plans
    resources :coupons
  end

  namespace :account do 
    resource :subscription
    resource :card, only: [:show, :new, :create]
  end
end
