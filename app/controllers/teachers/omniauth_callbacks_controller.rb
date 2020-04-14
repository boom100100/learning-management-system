# frozen_string_literal: true

class Teachers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def github
    #You need to implement the method below in your model (e.g. app/models/user.rb)
    if session.delete(:action) == 'sign_in'

      @user = Teacher.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted? || @user.save
        sign_in(:teacher, @user)#, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
      else
        session["devise.github_data"] = request.env["omniauth.auth"]
        redirect_to new_teacher_registration_path
      end

    elsif session.delete(:action) == 'sign_up'
      Teachers::RegistrationsController.new.create
      # @user = Teacher.find_or_create_by(uid: auth['uid']) do |u|
      #   u.email = auth['info']['email']
      # end

      #session[:type] = @user.id

      #redirect_to @user
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  def passthru
    super
  end

  # GET|POST /users/auth/twitter/callback
  def failure
    super
  end

  # def origin_url_on_success
  #   request.env['omniauth.origin']
  # end

  protected

  # The path used when OmniAuth fails
  def after_omniauth_failure_path_for(scope)
    super(scope)
  end
end
