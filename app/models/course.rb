class Course < ApplicationRecord
  has_many :lessons
  has_many :tags, through: :lessons

  belongs_to :teacher

  has_many :course_students
  has_many :students, through: :course_students

  scope :by_status, -> (status) { where('status = ?', status) }
  scope :published, -> { by_status("public") }
  scope :drafts, -> { by_status("draft") }
end
