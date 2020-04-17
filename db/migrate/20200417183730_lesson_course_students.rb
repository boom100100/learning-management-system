class LessonCourseStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :lesson_course_students do |t|
      t.boolean :completed

      t.belongs_to :lesson
      t.belongs_to :course_student
    end
  end
end
