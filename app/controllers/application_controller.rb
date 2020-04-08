class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  configure do


    enable :sessions
    set :session_secret, 'password_security' #todo change
  end
  def index
  end
end
