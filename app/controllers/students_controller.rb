class StudentsController < ApplicationController
  def create
    student = Student.create(student_params)
    redirect_to student_path(student) if student
  end

  private
  def student_params
    params.require(:student).permit(:username, :password, :password_confirmation)
  end
end
