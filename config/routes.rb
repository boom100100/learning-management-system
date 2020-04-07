Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => 'sessions#new'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#logout'

  resources :admins
  resources :students
  resources :teachers

  resources :courses
end
