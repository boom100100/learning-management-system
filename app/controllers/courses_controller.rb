class CoursesController < ApplicationController
  before_action :authorize_teacher_or_admin, except: [:index, :show]

  def index
    @courses = Course.all.published
    @teacher_or_admin = visitor_teacher_or_admin?
  end

  def drafts
    @courses = Course.all.drafts
    #@teacher_or_admin = visitor_teacher_or_admin?
  end

  def new
    @course = Course.new
    @teachers = Teacher.all.collect{|element| [element.email, element.id]}
  end

  def create
    course = Course.create(course_params)
    if course
      redirect_to courses_path
    else
      'Couldn\'t create course.'
    end
  end

  def show
    @course = Course.find_by(id: params[:id])
    @teacher_or_admin = visitor_teacher_or_admin?
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

  private

  def course_params
    params.require(:course).permit(:name, :description, :status, :teacher_id)
  end
end
