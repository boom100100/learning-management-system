class StudentsController < ApplicationController
  before_action :authorize_admin, only: [:new, :create]
  before_action :authorize_self_or_admin, only: [:edit, :update, :destroy]

  def index
    @students = Student.all
    @is_admin = admin?
  end

  def new
    @student = Student.new
  end

  def create
    student = Student.create(student_params)
    if student
      redirect_to(students_path)
    else
      redirect_to(new_student_path)
    end
  end

  def show
    @student = Student.find_by(id: params[:id])
    @courses = @student.courses.collect{|c| [c, c.name]}
    @visitor_is_self = visitor_is_self?
    @visitor_self_or_admin = visitor_self_or_admin?
  end

  def edit
    @student = Student.find_by(id: params[:id])
  end

  def update
    student = Student.find_by(id: params[:id])
    student.update(student_params)
    redirect_to student
  end

  def destroy
    id = params[:id]
    student = Student.find_by(id: id)

    student.destroy

    if session[:type] == 'student' && session[:user_id] == id
      reset_session
      return redirect_to root_path
    end

    redirect_to students_path
  end

  def add_course # TODO: add is_student validation
    #adds course to user's courses
    student = Student.find_by(id: session[:user_id])
    course = Course.find_by(id: params[:course_id])
    student.courses << course
    student.save
    redirect_to course
  end

  def remove_course
    #removes course from user's courses
    student = Student.find_by(id: session[:user_id])
    course = Course.find_by(id: params[:course_id])
    student.courses.delete(course)
    student.save
    redirect_to course
  end

  private
  def student_params
    params.require(:student).permit(:email, :password, :password_confirmation)
  end
end
