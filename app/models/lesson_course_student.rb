class LessonCourseStudent < ApplicationRecord
  belongs_to :lesson
  belongs_to :course_student

  scope :by_progress, -> (progress) { where('completed = ?', progress) }
  scope :complete_lessons, -> { by_progress(true) }
  scope :incomplete_lessons, -> { by_progress(false) }
end
