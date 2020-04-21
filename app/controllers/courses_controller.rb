class CoursesController < ApplicationController
  before_action :authorize_owner_or_admin, except: [:index, :show, :new, :create, :my_courses]
  before_action :authorize_teacher_or_admin, only: [:new, :create]
  before_action :authorize_teacher_or_student, only: [:my_courses]

  def index
    if params[:teacher_id]
      @courses = Teacher.find_by(id: params[:teacher_id]).courses
    elsif params[:student_id]
      @courses = Student.find_by(id: params[:student_id]).courses
    elsif params[:tag_id]
      @courses = Tag.find_by(id: params[:tag_id]).courses
    else
      @courses = Course.all.published
    end
    @teacher_or_admin = visitor_teacher_or_admin?
  end

  def new
    @course = Course.new(teacher_id: params[:teacher_id])
    @teachers = Teacher.all.collect{|element| [element.email, element.id]}
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path
    else
      @teachers = Teacher.all.collect{|element| [element.email, element.id]}
      render :new

    end
  end

  def show
    @course = Course.find_by(id: params[:id])
    @teacher_or_admin = visitor_teacher_or_admin?
    @visitor_is_self = (@course.teacher_id == current_teacher.id) if current_teacher
    #a student is signed in
    if current_student
      #is student enrolled in this lesson's course?
      #will decide if button to mark lesson completed will appear
      @course_student = CourseStudent.find_by(course: @course, student: Student.find_by(id: current_student.id))
    end
  end

  def edit
    @course = Course.find_by(id: params[:id])
    @teachers = Teacher.all.collect{|element| [element.email, element.id]}
    @visitor_is_self = (@course.teacher_id == current_teacher.id) if current_teacher
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
