class ApplicationController < ActionController::Base
  protect_from_forgery

  configure do


    enable :sessions
    set :session_secret, 'password_security' #todo change
  end
  def index
  end

  private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    '/'
  end
end
