Tang::Engine.routes.draw do
  mount StripeEvent::Engine, at: '/stripe_event'

  namespace :admin do
    get :dashboard, to: 'dashboard#index'
    resources :customers, only: [:index, :show, :edit, :update, :destroy] do
      get :coupon
      put :coupon, to: 'customers#apply_coupon'
      delete :coupon, to: 'customers#remove_coupon'
    end
    resources :payments, only: [:index, :show]
    resources :subscriptions, only: [:index, :show, :edit, :update, :destroy] do
      get :coupon
      put :coupon, to: 'subscriptions#apply_coupon'
      delete :coupon, to: 'subscriptions#remove_coupon'
    end
    resources :plans
    resources :coupons, only: [:index, :show, :new, :create, :destroy]
    resources :invoices, only: [:show]
    get :search, to: 'search#index'

    root to: 'dashboard#index'
  end

  namespace :account do
    resource :subscription
    resource :card, only: [:show, :new, :create, :update, :destroy]
    resource :coupon, only: [:create, :destroy]
    resources :receipts, only: [:index]
  end

  # get 'pricing', to: 'plans#index'

  # get 'unauthorized', to: 'errors#unauthorized'
end
