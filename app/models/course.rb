class Course < ApplicationRecord
  has_many :lessons
  has_many :tags
  
  belongs_to :teacher
  belongs_to :students
end
