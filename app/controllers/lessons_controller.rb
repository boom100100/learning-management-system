class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find_by(params[:id])
  end

  def download_dir
    #user must upload .zip file.
    send_file(Rails.root.join('public', 'docs/les.zip'), :type=>"application/zip" , :x_sendfile=>true) # TODO: edit path

  end
end
