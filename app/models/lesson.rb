class Lesson < ApplicationRecord
  belongs_to :tag
  belongs_to :course
end
