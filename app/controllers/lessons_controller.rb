class LessonsController < ApplicationController
  def index
    if params[:teacher_id]
      @lessons = Teacher.find_by(id: params[:teacher_id]).lessons
    elsif params[:student_id]
      @lessons = Student.find_by(id: params[:student_id]).lessons
    else
      @lessons = Lesson.all
    end
  end

  def new
    @lesson = Lesson.new
    @courses = Course.all.collect { |p| [ p.name, p.id ] }
    @tags = Tag.all
  end

  def create
    lesson = Lesson.new(lesson_params)
    #lesson.tags = Tag.where(id: params[:lesson][:tag_ids])

    if lesson.save!
      redirect_to lessons_path
    else
      'Couldn\'t create lesson.'
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
  end

  def edit
    @lesson = Lesson.find_by(id: params[:id])
    @courses = Course.all.collect { |p| [ p.name, p.id ] }
    @tags = Tag.all
  end

  def update

    lesson = Lesson.find_by(id: params[:id])
    lesson.update(lesson_params)
    lesson.tags = Tag.where(id: params[:lesson][:tag_ids])

    lesson.save
    redirect_to lesson
  end

  def destroy
    lesson = Lesson.find_by(id: params[:id])
    lesson.destroy
    redirect_to lessons_path
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
    params.require(:lesson).permit(:name, :description, :tag_ids, :content, :transcript, :video_url, :dir_url, :course_id)
  end
end
