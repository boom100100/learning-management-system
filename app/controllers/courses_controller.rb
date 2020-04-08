class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
  end

  def show
    @course = Course.find_by(id: params[:id])
  end
end
