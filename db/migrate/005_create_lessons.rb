class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.string :content
      t.string :transcript
      t.string :video_url
      t.string :dir_url #for shared files

      t.integer :course_id
    end
  end
end
