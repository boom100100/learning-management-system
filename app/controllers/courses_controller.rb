class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new # TODO: needs authorization restrictions
    @course = Course.new
    @teachers = Teacher.all.collect{|element| [element.username, element.id]}

  end

  def create # TODO: needs authorization restrictions
    # TODO: create failed. course.save! #error: ActiveRecord::RecordInvalid (Validation failed: Teacher must exist, Student must exist)

    course = Course.create(course_params)
    course.teacher = Teacher.find_by(id: params[:course][:teacher])
    course.save
    if course
      redirect_to courses_path
    else
      'Couldn\'t create course.'
    end
  end

  def show
    @course = Course.find_by(id: params[:id])
  end

  def edit # TODO: needs authorization restrictions
    @course = Course.find_by(id: params[:id])
    @teachers = Teacher.all.collect{|element| [element.username, element.id]}
  end

  def update # TODO: needs authorization restrictions
    course = Course.find_by(id: params[:id])
    course.update(course_params)
    course.teacher = Teacher.find_by(id: params[:course][:teacher_id])
    course.save
    redirect_to course
  end

  def destroy # TODO: needs authorization restrictions
    course = Course.find_by(id: params[:id])
    course.destroy
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :description)
  end
end
