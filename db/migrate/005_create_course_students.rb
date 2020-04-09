class CreateCourseStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :course_students do |t|
      t.belongs_to :course
      t.belongs_to :student
    end
  end
end
