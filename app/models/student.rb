class Student < ApplicationRecord
  has_secure_password
  has_many :course_students
  has_many :courses, through: :course_students
  has_many :teachers, through: :courses
end
