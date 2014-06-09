class SkaterPracticesController < ApplicationController
  def create
    status = SkaterPractice.new valid_params
    status.save
    if status.status == 'vacation'
      Skater.find(params[:skater_practice][:skater_id]).use_vacation_day
    end
    render json: status
  end

  def update
    status = SkaterPractice.find(params[:id])
    if status.status == 'vacation' && params[:skater_practice][:status] != 'vacation'
      Skater.find(params[:skater_practice][:skater_id]).add_vacation_day
    elsif status.status != 'vacation' && params[:skater_practice][:status] == 'vacation'
      Skater.find(params[:skater_practice][:skater_id]).use_vacation_day
    end
    status.update(valid_params)
    render json: status
  end

  private
    def valid_params
      params.require(:skater_practice).permit(:skater_id, :practice_id, :status)
    end
end
