class Tag < ApplicationRecord
  has_many :lesson_tags
  has_many :lessons, through: :lesson_tags

  has_many :courses, through: :lessons
end
