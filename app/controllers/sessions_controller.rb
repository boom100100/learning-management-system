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
    elsif type == ''
      user = Admin.find_by(username: params[:username])
    else
      user = Teacher.find_by(username: params[:username])
    end

    if user && user.authenticate(params[:password])
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

    elsif user
      render 'Enter the correct username or password to access this account.'
    else
      render 'User not found. You must choose the correct account type to sign in.'
    end
  end

  def logout
    reset_session
    redirect_to root
  end
end
