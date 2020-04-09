class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def show
    @lesson = Lesson.find_by(params[:id])
  end

  def download_dir
    Dir["*"].each do |file|
      if File.directory?(file)
        `zip -r "#{file}.zip" "#{file}"`
      end
    end
    send_file(Rails.root.join('public', 'docs/les.zip'), :type=>"application/zip" , :x_sendfile=>true) # TODO: edit path
    redirect_back
  end
end
