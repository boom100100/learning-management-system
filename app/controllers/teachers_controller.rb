class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end
  def new
    @teacher = Teacher.new
  end
  def create
    teacher = Teacher.create(teachers_params)
    teacher ? redirect_to(teachers_path) : redirect_to(new_teacher_path)
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
    teacher = Teacher.find_by(id: params[:id])
    teacher.destroy
    redirect_to teachers_path
  end
  private
  def teacher_params
    params.require(:teacher).permit(:username, :password, :password_confirmation)
  end
end
