class Course < ApplicationRecord
  has_many :lessons
  has_many :tags, through: :lessons

  belongs_to :teacher

  has_many :course_students
  has_many :students, through: :course_students

  scope :by_status, -> (status) { where('status = ?', status) }
  scope :published, -> { by_status("public") }
  scope :drafts, -> { by_status("draft") }

  validates :description, length: { minimum: 10 }
  validates :name, presence: true, uniqueness: { case_sensitive: false, message: 'This course name is already taken.' }, length: { minimum: 1 }
  validates :status, presence: true
  validates :teacher, presence: true
end
