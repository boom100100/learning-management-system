Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => 'sessions#new'
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  resources :admins

  resources :students do
    get '/add_course', to: 'students#add_course'
    get '/remove_course', to: 'students#remove_course'
  end

  resources :teachers


  resources :courses

  resources :lessons
  get '/download_files', to: 'lessons#download_dir'
end
