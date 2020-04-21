class LessonsController < ApplicationController
  before_action :authorize_owner_or_admin, except: [:index, :show, :new, :create, :my_courses]
  before_action :authorize_teacher_or_admin, only: [:new, :create]
  before_action :authorize_user, only: [:show]
  before_action :authorize_teacher_or_student, only: [:my_lessons]

  def index
    if params[:teacher_id]
      @lessons = Teacher.find_by(id: params[:teacher_id]).lessons
    elsif params[:student_id]
      @lessons = Student.find_by(id: params[:student_id]).lessons
    else
      @lessons = Lesson.all.published
    end
    @teacher_or_admin = (admin? || teacher?)
  end

  def new
    @lesson = Lesson.new(course_id: params[:course_id])
    @courses = Course.all.collect { |p| [ p.name, p.id ] }
    @tags = Tag.all#.collect { |t| [ t.name, t.id ] }
  end

  def create
    @lesson = Lesson.new(lesson_params)

    #gets rid of blanks, set tags
    params[:lesson][:tag_ids] = params[:lesson][:tag_ids].reject { |t| t.empty? }
    @lesson.tags = Tag.where(id: params[:lesson][:tag_ids])

    if @lesson.valid?

      @lesson.save
      redirect_to @lesson
    elsif params[:lesson][:tag_ids] == []
      @courses = Course.all.collect { |p| [ p.name, p.id ] }
      @tags = Tag.all#.collect { |t| [ t.name, t.id ] }
      render :new#plain: "#{params[:lesson][:tag_ids]}, #{@lesson.tags}"
    elsif !@lesson.valid?
      @courses = Course.all.collect { |p| [ p.name, p.id ] }
      @tags = Tag.all


      @lesson.zip_file = params[:lesson][:zip_file] if params[:lesson][:zip_file]
      @lesson.save ? redirect_to(@lesson ) : render(plain: "#{params[:lesson][:tag_ids]}, #{@lesson.tags}, #{@lesson.errors.full_messages}")
    end
  end

  def show
    @lesson = Lesson.find_by(id: params[:id])
    @visitor_owner_or_admin = visitor_is_owner? || admin?
    @visitor_is_self = (@lesson.course.teacher.id == current_teacher.id) if current_teacher

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
    @tags = Tag.all#.collect { |t| [ t.name, t.id ] }
  end

  def update
    @lesson = Lesson.find_by(id: params[:id])
    params[:lesson][:tag_ids] = params[:lesson][:tag_ids].reject { |t| t.empty? }
    @lesson.tags = Tag.where(id: params[:lesson][:tag_ids])

    if @lesson.valid?
      @lesson.update(lesson_params)
      @lesson.save
      redirect_to @lesson
    elsif params[:lesson][:tag_ids] = []
      # workaround for model validation - validation won't recognize when there are no collection_select options selected.


      #@lesson.errors.add(:tag_ids, "must include at least one tag")
      @courses = Course.all.collect { |p| [ p.name, p.id ] }
      @tags = Tag.all#.collect { |t| [ t.name, t.id ] }
      render :edit#plain: "#{params[:lesson][:tag_ids]}, #{@lesson.tags}"
    elsif !@lesson.valid?
      @courses = Course.all.collect { |p| [ p.name, p.id ] }
      @tags = Tag.all

      @lesson.zip_file = params[:lesson][:zip_file] if params[:lesson][:zip_file]
      @lesson.save ? redirect_to(@lesson ) : render(:edit)
    end
  end

  def destroy
    lesson = Lesson.find_by(id: params[:id])
    lesson.destroy
    redirect_to lessons_path
  end

  def destroy_zip_file
    @lesson = Lesson.find_by(id: params[:lesson_id])
    @lesson.zip_file.purge if @lesson.zip_file
    redirect_to @lesson
  end

  def drafts
    @lessons = Lesson.all.drafts
  end

  def my_lessons
    if current_student
      @lessons = Student.find_by(id: current_student.id).lesson_course_students.lessons
    else
      @lessons = Teacher.find_by(id: current_teacher.id).courses.collect {|course| course.lessons }.flatten
      @teacher = true
    end

  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :description, :tag_ids, :content, :transcript, :video_url, :zip_file, :status, :course_id)
  end
end
