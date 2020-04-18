class StudentsController < ApplicationController
  before_action :authorize_admin, only: [:new, :create]
  before_action :authorize_self_or_admin, only: [:edit, :update, :destroy, :add_course, :remove_course]

  def index
    @students = Student.all
    @is_admin = admin?
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path
    else
      render :new
    end
  end

  def show
    @student = Student.find_by(id: params[:id])
    @courses = @student.courses.collect{|c| [c, c.name]}
    @visitor_is_self = visitor_is_self?
    @visitor_self_or_admin = visitor_self_or_admin?
  end

  def edit
    @student = Student.find_by(id: params[:id])
  end

  def update
    student = Student.find_by(id: params[:id])
    Student.validators_on(params[:student][:email])

    #is email invalid?
    if student.errors.size > 0
      flash[:error] = "Email invalid. #{params[:student][:email]}"
      redirect_to edit_student_path

    #are passwords empty?
    elsif params[:student][:password] == '' && params[:student][:password_confirmation] == ''
      student.update_attribute('email', params[:student][:email])
      flash[:notice] = 'Email updated successfully.'
      redirect_to student

    #passwords don't match?
    elsif params[:student][:password] != params[:student][:password_confirmation]
      flash[:error] = "Passwords don\'t match."
      redirect_to edit_student_path

    #passwords match?
    elsif (params[:student][:password] == params[:student][:password_confirmation]) && params[:student][:password].length > 5
      student.update(student_params)
      flash[:notice] = 'Email and/or password updated successfully.'
      redirect_to student
    else
      redirect_to edit_student_path
    end
  end

  def destroy
    id = params[:id]
    student = Student.find_by(id: id)

    student.destroy

    redirect_to students_path
  end

  def add_course # TODO: add is_student validation
    #adds course to user's courses
    student = Student.find_by(id: current_student.id)
    course = Course.find_by(id: params[:course_id])

    course_student = CourseStudent.create(course: course, student: student)
    course.lessons.each {|lesson| LessonCourseStudent.create!(completed: false, course_student: course_student, lesson: lesson)}

    redirect_to course
  end

  def remove_course
    #removes course from user's courses
    student = Student.find_by(id: current_student.id)
    course = Course.find_by(id: params[:course_id])

    course_student = CourseStudent.find_by(course: course, student: student)
    course.lessons.each {|lesson| lesson.lesson_course_students.destroy_all }
    course_student.destroy

    redirect_to course
  end

  def lesson_complete
    lcs = LessonCourseStudent.find_by(id: params[:lesson_course_student])
    lcs.completed = !lcs.completed
    lcs.save

    lcs.course_student.completed = false if lcs.completed == false
    lcs.course_student.save

    redirect_to lcs.lesson
  end

  def course_complete
    cs = CourseStudent.find_by(id: params[:course_student])
    cs.completed = !cs.completed
    cs.save

    cs.lesson_course_students.each {|lcs|
      lcs.completed = true
      lcs.save
    } if cs.completed == true

    redirect_to cs.course
  end

  private
  def student_params
    params.require(:student).permit(:email, :password, :password_confirmation)
  end
end
