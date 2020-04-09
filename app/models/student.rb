class Student < ApplicationRecord
  has_secure_password
  has_many :courses, through: :courses_students
  has_many :teachers, through: :courses
end
