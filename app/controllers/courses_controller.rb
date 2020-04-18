class CoursesController < ApplicationController
  before_action :authorize_teacher_or_admin, except: [:index, :show]
  before_action :authorize_teacher_or_student, only: [:my_courses]
  def index
    @courses = Course.all.published
    @teacher_or_admin = visitor_teacher_or_admin?
  end



  def new

    @course = Course.new
    @teachers = Teacher.all.collect{|element| [element.email, element.id]}
  end

  def create
    course = Course.new(course_params)
    if course.save
      redirect_to courses_path
    else


      flash[:error] = course.errors.full_messages.to_s

    end
  end

  def show
    @course = Course.find_by(id: params[:id])
    @teacher_or_admin = visitor_teacher_or_admin?
    #a student is signed in
    if current_student
      #is student enrolled in this lesson's course?
      #will decide if button to mark lesson completed will appear
      @course_student = CourseStudent.find_by(course: @course, student: Student.find_by(id: current_student.id))
    end
  end

  def edit
    @course = Course.find_by(id: params[:id])
    @teachers = Teacher.all.collect{|element| [element.username, element.id]}
  end

  def update
    course = Course.find_by(id: params[:id])
    course.update(course_params)
    redirect_to course
  end

  def destroy
    course = Course.find_by(id: params[:id])
    course.lessons.destroy_all
    course.destroy
    redirect_to courses_path
  end

  def drafts
    @courses = Course.all.drafts
    #@teacher_or_admin = visitor_teacher_or_admin?
  end

  def my_courses

    if current_student
      @courses = Student.find_by(id: current_student.id).courses
    else
      @courses = Teacher.find_by(id: current_teacher.id).courses
      @teacher = true
    end

  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :status, :teacher_id)
  end
end
