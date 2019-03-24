class Inspection < ApplicationRecord
  has_one_attached :image

  belongs_to :lesson
  belongs_to :student
end
