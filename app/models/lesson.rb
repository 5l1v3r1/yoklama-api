class Lesson < ApplicationRecord
  has_and_belongs_to_many :students

  has_many :inspections
  has_many :inspections_students, through: :inspections, source: :student
end
