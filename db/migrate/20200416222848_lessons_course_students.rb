class LessonsCourseStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons_course_students, :id => false do |t|
      t.boolean :completed

      t.belongs_to :lesson
      t.belongs_to :course_student
    end
  end
end
