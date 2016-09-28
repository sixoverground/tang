Rails.application.routes.draw do
  devise_for :users
  mount Tang::Engine => "/tang"
  root 'home#index'
end
