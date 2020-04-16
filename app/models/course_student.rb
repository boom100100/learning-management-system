class CourseStudent < ApplicationRecord
  belongs_to :course
  belongs_to :student

  has_many :lessons_course_students
  has_many :lessons, through: :lessons_course_students

end
