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

  private
    def date_from_params date
      DateTime.new(date['date(1i)'].to_i, date['date(2i)'].to_i, date['date(3i)'].to_i)
    end

end
