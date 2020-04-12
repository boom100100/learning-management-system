class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end
  def show
    @tag = Tag.find_by(id: params[:id])
  end
end
