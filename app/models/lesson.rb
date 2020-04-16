class Lesson < ApplicationRecord
  has_many :lesson_tags
  has_many :tags, through: :lesson_tags

  belongs_to :course

  scope :by_status, -> (status) { where('status = ?', status) }
  scope :published, -> { by_status("public") }
  scope :drafts, -> { by_status("draft") }
end
