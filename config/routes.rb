Rails.application.routes.draw do

  root :to => 'sessions#new'

  resources :admins
  devise_for :admins, :controllers => {:registrations => "admins/registrations", :sessions => "admins/sessions", :passwords => "admins/passwords" }
  devise_scope :admin do
    get "/admins/auth/github/callback" => "admins/omniauth_callbacks#github"
  end
  #get '/auth/github'
  get '/auth/github/callback', to: 'sessions#github_auth'
  devise_for :teachers, :controllers => {:registrations => "teachers/registrations", :sessions => "teachers/sessions", :passwords => "teachers/passwords" }
  devise_scope :teacher do
    #get "/teachers/auth/github"
    #get "/teachers/auth/github/callback" => "teachers/omniauth_callbacks#github"
    resources :courses
  end
  resources :teachers do
    resources :courses
  end

  devise_for :students, :controllers => {:registrations => "teachers/registrations", :sessions => "students/sessions", :passwords => "students/passwords" }
  devise_scope :student do
    get "/students/auth/github/callback" => "students/omniauth_callbacks#github"
  end

  resources :students do
    get '/add_course', to: 'students#add_course'
    get '/remove_course', to: 'students#remove_course'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  # get '/auth/github/callback', to: 'sessions#github_auth'
  #get '/auth/failure', to: redirect('/')
  # post '/login', to: 'sessions#create'
  #
   get '/logout', to: 'sessions#destroy'





  resources :courses do
    resources :lessons
    resources :students, only: [:index, :show]
  end

  resources :lessons
  get '/download_files', to: 'lessons#download_dir'

  resources :tags do
    resources :courses, only: [:index, :show]
  end
end
