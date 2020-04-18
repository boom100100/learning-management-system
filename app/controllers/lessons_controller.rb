class LessonsController < ApplicationController
  before_action :authorize_teacher_or_admin, except: [:index, :show]
  before_action :authorize_user, only: [:show]
  before_action :authorize_teacher_or_student, only: [:my_lessons]

  def index
=begin
    if params[:teacher_id]
      @lessons = Teacher.find_by(id: params[:teacher_id]).lessons
    elsif params[:student_id]
      @lessons = Student.find_by(id: params[:student_id]).lessons
    else
      @lessons = Lesson.all
    end
=end
    @lessons = Lesson.all
    @teacher_or_admin = (admin? || teacher?)
  end

  def drafts
    @lessons = Lesson.all.drafts
  end

  def new
    @lesson = Lesson.new
    @courses = Course.all.collect { |p| [ p.name, p.id ] }
    @tags = Tag.all
  end

  def create
    lesson = Lesson.new(lesson_params)
    #lesson.tags = Tag.where(id: params[:lesson][:tag_ids])

    if lesson.save
      redirect_to lesson
    else
      flash[:error] = 'Could not create lesson.'
      redirect_to new_lesson_path
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
    #a student is signed in
    if current_student
        #is student enrolled in this lesson's course?
        #will decide if button to mark lesson completed will appear
        @student = Student.find_by(id: current_student.id)
        @course_student = CourseStudent.find_by(course: @lesson.course, student: @student)

        @lesson_course_student = @lesson.lesson_course_students.find_by(course_student: @course_student, lesson: @lesson)
    end
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

  def my_lessons
    if current_student
      @lessons = Student.find_by(id: current_student.id).lesson_course_students.lessons
    else
      @lessons = Teacher.find_by(id: current_teacher.id).courses.collect {|course| course.lessons }.flatten
      @teacher = true
    end

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
    params.require(:lesson).permit(:name, :description, :tag_ids, :content, :transcript, :video_url, :dir_url, :status, :course_id)
  end
end
