Tang::Engine.routes.draw do
  mount StripeEvent::Engine, at: '/stripe_event'

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :subscriptions, only: [:index, :show, :edit, :update, :destroy]
    resources :plans
    resources :coupons
    resources :charges, only: [:show]
  end

  namespace :account do
    resource :subscription
    resource :card, only: [:show, :new, :create]
    resources :charges, only: [:index, :show]
  end

  get 'unauthorized', to: 'errors#unauthorized'
end
