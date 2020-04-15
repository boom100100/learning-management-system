# frozen_string_literal: true

class Teachers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def github
    #You need to implement the method below in your model (e.g. app/models/user.rb)

    if session[:type] == 'teacher'
      @user = Teacher.from_omniauth(request.env["omniauth.auth"])
      complete_github(@user, :teacher, new_teacher_registration_path)

    elsif session[:type] == 'student'
      @user = Student.from_omniauth(request.env["omniauth.auth"])
      complete_github(@user, :student, new_teacher_registration_path)
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

  private

  def complete_github(user, type_hash, registration_path)
    if user.persisted? || user.save
      sign_in(type_hash, user)#, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to registration_path
    end
  end
end
