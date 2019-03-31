class InspectionsController < ApplicationController
    def create
        @inspection = Inspection.new
        @inspection.image.attach(params[:image])
        @inspection.lesson = Lesson.first
        @inspection.student = Student.first
        if @inspection.save!
            render json: { message: "Yoklama Başarıyla alındı." }
            active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
            puts active_storage_disk_service.send(:path_for, @inspection.image.blob.key)
        else
            render json: { message: "Hata Oluştu." }
        end
    end
    def show
        @inspection = Inspection.find(params[:id])
    end
end
