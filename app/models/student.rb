class Student < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :number, presence: true

  has_and_belongs_to_many :lessons

  has_many :inspections
  has_many :inspections_lessons, through: :inspections, source: :lesson
end
