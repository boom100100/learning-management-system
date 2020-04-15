class SessionsController < ApplicationController
  def new # TODO: determine user type.
    @admin = Admin.new
    @teacher = Teacher.new
    @student = Student.new
  end

  def github_auth
    redirect_to root_path
  end

  def create
    type = params[:account_type]
    user = nil

    if type == 'student'
      user = Student.find_by(email: params[:email])
      authenticate_student!
    elsif type == 'admin'
      user = Admin.find_by(email: params[:email])
      authenticate_admin!
    else
      user = Teacher.find_by(email: params[:email])
      authenticate_teacher!
    end

    user = user.try(:authenticate, params[:password])
    #return redirect_to(controller: 'sessions', action: 'login') unless user
    return 'user failed' unless user

    session[:user_id] = user.id
    is_admin = user.instance_of?(Admin)

    if is_admin
      session[:type] = 'admin'
      session[:privilege] = 'admin'
    else
      session[:type] = type
      session[:privilege] = type
    end

    redirect_to user
  end

  def destroy # TODO: done
    reset_session
    redirect_to root_path
  end
end
