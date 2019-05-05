require "FaceRecognition"

class InspectionsController < ApplicationController
    def create
      
      begin  
        lessons = Lesson.pluck :id
        lesson_id = lessons[params["lesson_number"].to_i]
        insp_image = InspectionImage.new()
        insp_image.image.attach(params[:image])
        if insp_image.save!
          active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
          student_nos = FaceRecognition.identify(active_storage_disk_service.send(:path_for, insp_image.image.blob.key))
          puts "yüz algılanamadı : " + student_nos.last.to_s
          render json: { message: (student_nos.last.to_s + " yüz algılanamadı.") } and return unless student_nos.last == 0
          student_nos = student_nos.first
          puts "Öğrenci numaraları : " + student_nos.join(", ")
          silinecekler = []
          student_nos.each do |no|
            puts no
            @inspection = Inspection.new
            @inspection.lesson = Lesson.find(lesson_id)
            @inspection.student = Student.find_by(number: no.to_i)
            puts "ekleniyor"
            
            if @inspection.lesson.students.include? @inspection.student 
              puts @inspection.save!
              puts "eklendi"
            else
              puts "eklenemedi"
              silinecekler << no
            end
          end
          student_nos -= silinecekler
          render json: { message: "Yoklama Başarıyla alındı. Öğrenciler: #{student_nos.join(",") unless student_nos.empty?} " + "\n#{silinecekler.count} kişi bu dersi almıyor." }
        else
          render json: { message: "Hata Oluştu." }
        end
      rescue StandardError => msg
        render json: { message: "Hata Oluştu." }
      end  
      
    end
    def show
      @inspection = Inspection.find(params[:id])
    end

    def list
      date = Date.new(params["yil"].to_i, params["ay"].to_i, params["gun"].to_i)
      puts "Vakit " + date.to_s
      @inspections = Inspection.select(:student_id)
                               .where( lesson_id: params["ders_id"].to_i + 1, created_at: (date)..(date + 1.day) )
                               .group(:student_id)
      
      kisiler = @inspections.map { |inspection| inspection.student.number }

      render json: { message: kisiler }
    end
end
