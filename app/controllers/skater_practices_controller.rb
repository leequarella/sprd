class SkaterPracticesController < ApplicationController
  def create
    status = SkaterPractice.new valid_params
    status.save
    render json: status
  end

  def update
    status = SkaterPractice.find(params[:id])
    status.update(valid_params)
    render json: status
  end

  private
    def valid_params
      params.require(:skater_practice).permit(:skater_id, :practice_id, :status)
    end
end
