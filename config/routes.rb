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
    resources :invoices, only: [:index, :show]
  end

  namespace :account do
    resource :subscription
    resource :card, only: [:show, :new, :create]
    resources :charges, only: [:index, :show]
  end

  # get 'unauthorized', to: 'errors#unauthorized'
end
