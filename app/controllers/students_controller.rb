class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    student = Student.create(student_params)
    if student
      session[:user_id] = student.id
      session[:type] = 'student'
      session[:privilege] = 'student'

      redirect_to(students_path)
    else
      redirect_to(new_student_path)
    end
  end

  def show
    @student = Student.find_by(id: params[:id])
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
    params.require(:student).permit(:username, :password, :password_confirmation)
  end
end
