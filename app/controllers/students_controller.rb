class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    student = Student.create(student_params)
    redirect_to student_path(student) if student
  end

  def index
    @students = Student.all
  end

  def show
    @student = Student.find_by(id: params[:id])
  end

  private
  def student_params
    params.require(:student).permit(:username, :password, :password_confirmation)
  end
end
