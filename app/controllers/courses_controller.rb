class CoursesController < ApplicationController
  def index # TODO: needs authorization restrictions
    @courses = Course.all
  end

  def new # TODO: needs authorization restrictions
    @course = Course.new
  end

  def create
    course = Course.create(courses_params)
    redirect_to course
  end

  def show # TODO: needs authorization restrictions
    @course = Course.find_by(id: params[:id])
  end

  def edit # TODO: needs authorization restrictions
    @course = Course.find_by(id: params[:id])
  end

  def update
    course = Course.find_by(id: params[:id])
    redirect_to course
  end

  def destroy # TODO: needs authorization restrictions
    course = Course.find_by(id: params[:id])
    course.destroy
    redirect_to courses_path
  end

  private

  def courses_params # TODO: needs authorization restrictions
    params.require(:course).permit(:name, :description)
  end
end
