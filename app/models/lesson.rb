class Lesson < ApplicationRecord
  has_many :lesson_tags
  has_many :tags, through: :lesson_tags

  belongs_to :course
end
