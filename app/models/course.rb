class Course < ApplicationRecord
  has_many :lessons
  has_many :tags, through: :lessons

  belongs_to :teacher
  belongs_to :student
end
