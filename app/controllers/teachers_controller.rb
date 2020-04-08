class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end
  def new
  end
  def create
  end
  def show
  end
  def edit
  end
  def update
  end
  def destroy
  end
  private
  def teachers_params
  end
end
