require "FaceRecognition"

class InspectionsController < ApplicationController
    def create
      lessons = Lesson.pluck :id
      lesson_id = lessons[params["lesson_number"].to_i]

      @inspection = Inspection.new
      @inspection.image.attach(params[:image])
      @inspection.lesson = Lesson.find(lesson_id)
      @inspection.student = Student.first
      if @inspection.save!
        active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
        name = FaceRecognition.identify(active_storage_disk_service.send(:path_for, @inspection.image.blob.key))
        
        render json: { message: "Yoklama Başarıyla alındı. #{name}", users: name }
        
      else
        render json: { message: "Hata Oluştu." }
      end
    end
    def show
        @inspection = Inspection.find(params[:id])
    end
end
