class TagsController < ApplicationController
  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def show
    @tag = Tag.find_by(id: params[:id])
    @courses = @tag.courses
  end

  def create
    @tag = Tag.create(tag_params)
    unless @tag
      flash[:error] = 'Could not create tag.'
    end
    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
