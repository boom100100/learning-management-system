class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :course_id
      t.integer :lesson_id
    end
  end
end
