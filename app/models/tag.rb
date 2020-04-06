class Tag < ApplicationRecord
  has_many :lessons
  has_many :courses, through: :lesson
end
