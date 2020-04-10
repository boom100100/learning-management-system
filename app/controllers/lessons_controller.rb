class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def new
    @lesson = Lesson.new
    @courses = Course.all.collect{|element| [element.name, element.id]}
    @tags = Tag.all.collect{|element| [element.name, element.id]}

  end

  def create
    params[:lesson][:course] = Course.find_by(id: params[:lesson][:course].to_i)
    lesson = Lesson.new(lesson_params)
    #lesson.course = Course.find_by(id: params[:lesson][:course].to_i)
    lesson.tag = params[:lesson][:tag].each {|id| Tag.find_by(id: id) if !id.nil? }




    if lesson.save!
      redirect_to lessons_path
    else
      'Couldn\'t create lesson.'
    end
  end

  def show
    @lesson = Lesson.find_by(params[:id])
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
    params.require(:lesson).permit(:name, :description, :tag, :content, :transcript, :video_url, :dir_url, :course)
  end
end
