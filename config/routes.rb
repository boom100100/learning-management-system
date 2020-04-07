Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => 'accounts#signup'
  post '/accounts', to: 'accounts#create'
  get '/logout', to: 'accounts#logout'

  resources :admins
  resources :students
end
