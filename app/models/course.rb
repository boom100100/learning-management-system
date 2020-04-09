class Course < ApplicationRecord
  has_many :lessons
  has_many :tags, through: :lessons

  belongs_to :teacher
  has_many :students, through: :course_students
end
