class LessonsStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons_students do |t|
      t.integer :lesson_id
      t.integer :student_id
      
      t.timestamps
    end
  end
end
