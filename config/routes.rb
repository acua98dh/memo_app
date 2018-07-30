Rails.application.routes.draw do

  get 'users/show'
  devise_for :users, :controllers => {
    :registrations => "registrations"
  }
  resources :users, only: [:show]
  resources :tags
  resources :reviews
  root 'static_pages#home'
  match '/sign_in',    to: 'devise/sessions#new',    via: 'get'
  match '/sign_up',   to: 'registrations#new',   via: 'get'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
