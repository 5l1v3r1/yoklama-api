class AddReferencesToInspection < ActiveRecord::Migration[5.2]
  def change
    add_reference :inspections, :student, foreign_key: true
    add_reference :inspections, :lesson, foreign_key: true
  end
end
