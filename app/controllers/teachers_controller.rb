class TeachersController < ApplicationController

  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def create
    teacher = Teacher.create(teacher_params)
    if teacher
      redirect_to(teachers_path)
    else
      redirect_to(new_teacher_path)
    end
  end

  def show
    @teacher = Teacher.find_by(id: params[:id])
  end

  def edit
    @teacher = Teacher.find_by(id: params[:id])
  end

  def update
    teacher = Teacher.find_by(id: params[:id])
    teacher.update(teacher_params)
    redirect_to teacher
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
