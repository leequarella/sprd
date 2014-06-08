class ReportsController < ApplicationController
  def attendence_percentage
    if params[:start_date]
      start_date = date_from_params params[:start_date]
      end_date   = date_from_params params[:end_date]
    else
      start_date = 1.month.ago
      end_date   = 1.day.from_now
    end
    @report = AttendencePercentageReport.new(start_date: start_date,
                                             end_date:   end_date)
  end

end
