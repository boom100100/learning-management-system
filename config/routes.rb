Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root :to => 'application#index'


  ###admins
  ###devise paths go to admins/controllers
  #no github auth for admins (devise_scope)
  devise_for :admins, :controllers => {:registrations => "admins/registrations", :sessions => "admins/sessions", :passwords => "admins/passwords" }
  devise_scope :admin do
    resources :admins, :except => [:create]
    post '/admins/new_post', to: 'admins#create' #alternative create flow - not using devise.
  end

  devise_for :teachers, :controllers => {:registrations => "teachers/registrations", :sessions => "teachers/sessions", :passwords => "teachers/passwords" }
  devise_scope :teacher do
    post '/teachers/new_post', to: 'teachers#create' #alternative create flow - not using devise.
    resources :teachers, :except => [:create] do
      resources :courses
    end
    get "/auth/:provider/callback", to: "teachers/omniauth_callbacks#github"
  end


  devise_for :students, :controllers => {:registrations => "students/registrations", :sessions => "students/sessions", :passwords => "students/passwords" }
  devise_scope :student do
    post '/students/new_post', to: 'students#create' #alternative create flow - not using devise.
    resources :students, except: [:create] do
      resources :courses
      get '/add_course', to: 'students#add_course'
      get '/remove_course', to: 'students#remove_course'
    end

    get "/auth/github/callback" => "teachers/omniauth_callbacks#github" #####teachers handles all github auth
  end

  resources :students do
    resources :courses
    get '/add_course', to: 'students#add_course'
    get '/remove_course', to: 'students#remove_course'
  end

  get '/courses/drafts', to: 'courses#drafts'
  resources :courses do
    resources :lessons
    resources :students, only: [:index, :show]
  end

  get '/lessons/drafts', to: 'lessons#drafts'
  resources :lessons
  get '/download_files', to: 'lessons#download_dir'

  resources :tags do
    resources :courses, only: [:index, :show]
  end
end
