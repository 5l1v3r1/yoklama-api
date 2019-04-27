require "FaceRecognition"

class InspectionsController < ApplicationController
    def create
      lessons = Lesson.pluck :id
      lesson_id = lessons[params["lesson_number"].to_i]
      insp_image = InspectionImage.new()
      
      insp_image.image.attach(params[:image])
      if insp_image.save!
        active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
        student_nos = FaceRecognition.identify(active_storage_disk_service.send(:path_for, insp_image.image.blob.key))
        student_nos.each do |no|
          @inspection = Inspection.new
          @inspection.lesson = Lesson.find(lesson_id)
          @inspection.student = Student.find_by(number: no.to_i)
        end
        if @inspection.save!
          
          render json: { message: "Yoklama Başarıyla alındı. Öğrenciler: #{student_nos.join(",")}" }
        end
      else
        render json: { message: "Hata Oluştu." } 
      end
    end
    def show
        @inspection = Inspection.find(params[:id])
    end
end
