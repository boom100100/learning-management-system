class CreateLessonTags < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_tags do |t|
      t.belongs_to :lesson
      t.belongs_to :tag
    end
  end
end
