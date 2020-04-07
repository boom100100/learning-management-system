class SessionsController < ApplicationController
  def new # TODO: determine user type.
    @admin = Admin.new
    @teacher = Teacher.new
    @student = Student.new
  end

  def create
    type = params[:account_type]
    user = nil

    if type == 'student'
      user = Student.find_by(username: params[:username])
    elsif type == 'admin'
      user = Admin.find_by(username: params[:username])
    else
      user = Teacher.find_by(username: params[:username])
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
      session[:type] = params[:type]
      session[:privilege] = type
    end

    redirect_to user
  end

  def logout # TODO: done
    reset_session
    redirect_to root_path
  end
end
