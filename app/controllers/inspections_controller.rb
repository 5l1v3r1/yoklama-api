class InspectionsController < ApplicationController
    def create
        @inspection = Inspection.new
        @inspection.image.attach(params[:image])
        if @inspection.save!
            render json: { message: "Yoklama Başarıyla alındı." }
        else
            render json: { message: "Hata Oluştu." }
        end
    end
    def show
        @inspection = Inspection.find(params[:id])
    end
end
