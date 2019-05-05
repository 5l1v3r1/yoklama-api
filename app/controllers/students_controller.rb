class StudentsController < ApplicationController
    def index
        @students = Student.all
        render json: @students
      end
      def create
        @student = Student.new
        @student.name = params[:name]
        @student.surname = params[:surname]
        @student.number = params[:number]
        lessons = params[:lessons]
        lessons.split(' ').each do |lesson_id|
          @student.lessons << Lesson.find(lesson_id.to_i + 1)
        end
        if @student.save!
          render json: { message: "Başarıylayla Kaydedildi.", student: @student }
        else
          render json: { message: "Hata Oluştu" }
        end
      end
end
