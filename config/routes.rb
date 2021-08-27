Rails.application.routes.draw do
  root to: 'tweets#index'

  devise_for :users
  resources :tweets, except: :new
  resources :comments, except: %i[index new]
end
