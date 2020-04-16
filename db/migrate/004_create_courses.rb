class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :status

      t.belongs_to :teacher

      t.timestamps
    end
  end
end
