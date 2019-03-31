class LessonsController < ApplicationController
  def index
    lessons = Lesson.pluck :name
    render json: lessons
  end
end
