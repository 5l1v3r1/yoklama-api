class CreateJoinTableStudentsLessons < ActiveRecord::Migration[5.2]
  def change
    create_join_table :students, :lessons do |t|
      # t.index [:student_id, :lesson_id]
      # t.index [:lesson_id, :student_id]
    end
  end
end
