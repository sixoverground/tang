Rails.application.routes.draw do
  devise_for :users
  get :gold, to: 'gold#index'
  root 'home#index'
  mount Tang::Engine => "/"
end
