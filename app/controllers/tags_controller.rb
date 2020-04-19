class TagsController < ApplicationController
  before_action :authorize_teacher_or_admin, except: [:index, :show]

  def index
    @tag = Tag.new
    @tags = Tag.all
    @teacher_or_admin = (admin? || teacher?)
  end

  def new
    @tag = Tag.new
  end

  def show
    @tag = Tag.find_by(id: params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render :index
    end
  end

  def edit
    @tag = Tag.find_by(id: params[:id])
  end

  def update
    tag = Tag.find_by(id: params[:id])
    tag.update(tag_params)
    tag.save
    redirect_to tag
  end

  def destroy
    @tag = Tag.find_by(id: params[:id])
    @tag.destroy
    redirect_to tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
