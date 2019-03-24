class Student < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :number, presence: true


  has_and_belongs_to_many :lessons
  
end
