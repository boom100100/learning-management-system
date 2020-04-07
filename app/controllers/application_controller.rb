class ApplicationController < ActionController::Base
  protect_from_forgery
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, 'password_security'
  end
  def index
  end
end
