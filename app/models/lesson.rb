class Lesson < ApplicationRecord
  has_many :tags
  belongs_to :course
end
