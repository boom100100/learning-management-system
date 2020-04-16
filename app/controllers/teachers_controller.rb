class TeachersController < ApplicationController
  before_action :authorize_admin, only: [:new, :create]
  before_action :authorize_self_or_admin, only: [:edit, :update, :destroy]

  def index
    @teachers = Teacher.all
    @is_admin = admin?
  end

  def new
    @teacher = Teacher.new
  end

  def create
    teacher = Teacher.new(teacher_params)
    if teacher.valid?
      teacher.save
      redirect_to teachers_path
    else
      redirect_to new_teacher_path
    end
  end

  def show
    @teacher = Teacher.find_by(id: params[:id])
    @visitor_is_self = visitor_is_self?
    @visitor_self_or_admin = visitor_self_or_admin?
  end

  def edit
    @teacher = Teacher.find_by(id: params[:id])
  end

  def update
    teacher = Teacher.find_by(id: params[:id])
    Teacher.validators_on(params[:teacher][:email])

    #is email invalid?
    if teacher.errors.size > 0
      flash[:error] = "Email invalid. #{params[:teacher][:email]}"
      redirect_to edit_teacher_path

    #are passwords empty?
    elsif params[:teacher][:password] == '' && params[:teacher][:password_confirmation] == ''
      teacher.update_attribute('email', params[:teacher][:email])
      flash[:notice] = 'Email updated successfully.'
      redirect_to teacher

    #passwords don't match?
    elsif params[:teacher][:password] != params[:teacher][:password_confirmation]
      flash[:error] = "Passwords don\'t match."
      redirect_to edit_teacher_path

    #passwords match?
  elsif (params[:teacher][:password] == params[:teacher][:password_confirmation]) && params[:teacher][:password].length > 5
      teacher.update(teacher_params)
      flash[:notice] = 'Email and/or password updated successfully.'
      redirect_to teacher
    else
      redirect_to edit_teacher_path
    end
  end

  def destroy
    id = params[:id]
    teacher = Teacher.find_by(id: id)

    teacher.destroy

    if session[:type] == 'teacher' && session[:user_id] == id
      reset_session
      return redirect_to root_path
    end
    redirect_to teachers_path
  end

  private
  def teacher_params
    params.require(:teacher).permit(:email, :password, :password_confirmation)
  end
end
