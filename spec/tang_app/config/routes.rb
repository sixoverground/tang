Rails.application.routes.draw do
  devise_for :users
  get :diamond, to: 'diamond#index'
  get :gold, to: 'gold#index'
  root 'home#index'
  mount Tang::Engine => '/'
end
