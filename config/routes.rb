Rails.application.routes.draw do
  root 'welcome#index'

  resources :books do
    resources :reviews, only: [:new, :create]
  end

  # resources :reviews, only: [:show, :edit, :update]

  resources :authors

  resources :reviews, only: [:destroy]

  resources :users, only: [:show]
end
