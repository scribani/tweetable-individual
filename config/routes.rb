Rails.application.routes.draw do
  resources :users, only: :show
  resources :tweets, except: :new
end
