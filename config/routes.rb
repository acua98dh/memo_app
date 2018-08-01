Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => "registrations",
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }


  resources :users, only: [:show]
  root 'static_pages#home'
  match '/sign_in',    to: 'devise/sessions#new',    via: 'get'
  match '/sign_up',   to: 'registrations#new',   via: 'get'
  resources :tags do
    member do
      get :taggers
    end
  end
  resources :reviews do
    member do
      get :tagging
    end
  end
  resources :review_tags,       only: [:create, :destroy]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
