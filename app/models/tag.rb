class Tag < ApplicationRecord
  has_many :lessons
  has_many :courses, through: :lessons
end
