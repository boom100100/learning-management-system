class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def new
    @lesson = Lesson.new
    @courses = Course.all.collect { |p| [ p.name, p.id ] }
    @tags = Tag.all

  end

  def create
    lesson = Lesson.new(lesson_params)
    lesson.tags = Tag.where(id: params[:lesson][:tags])

    if lesson.save!
      redirect_to lessons_path
    else
      'Couldn\'t create lesson.'
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end



  def download_dir
    # TODO: validate for .zip file.
    send_file(Rails.root.join('public', "docs/#{params[:name]}.zip"), :type=>"application/zip" , :x_sendfile=>true) # TODO: edit path
  end

  def upload_dir
    # TODO: validate for .zip file.

  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :description, :tags, :content, :transcript, :video_url, :dir_url, :course_id)
  end
end
