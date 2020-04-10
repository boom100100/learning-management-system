class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new # TODO: needs authorization restrictions
    @course = Course.new
    @teachers = Teacher.all.collect{|element| [element.username, element.id]}

  end

  def create # TODO: needs authorization restrictions
    course = Course.create(course_params)
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
    redirect_to course
  end

  def destroy # TODO: needs authorization restrictions
    course = Course.find_by(id: params[:id])
    course.lessons.destroy_all
    course.destroy
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :teacher_id)
  end
end
