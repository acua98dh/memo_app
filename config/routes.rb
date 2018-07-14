Rails.application.routes.draw do
  resources :tags
  resources :reviews
  devise_for :users
  root 'static_pages#home'
#  match '/help',    to: 'static_pages#help',    via: 'get'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
