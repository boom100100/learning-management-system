class Lesson < ApplicationRecord
  has_many :lesson_tags
  has_many :tags, through: :lesson_tags

  belongs_to :course

  has_many :lessons_course_students
  has_many :course_students, through: :lessons_course_students


  scope :by_status, -> (status) { where('status = ?', status) }
  scope :published, -> { by_status("public") }
  scope :drafts, -> { by_status("draft") }
end
