class AttendencePercentageReport
  attr_accessor :practices, :skaters, :start_date, :end_date
  def initialize(data)
    @skaters    = Skater.all.order(:derby_name)
    @practices  = Practice.where("date > ? and date < ?", data[:start_date], data[:end_date])
    @start_date = data[:start_date]
    @end_date   = data[:end_date]
    calc
  end

  private
    def calc
      @skaters.each do |skater|
        skater.attendence_percentage = skater.attendence_percentage_for @practices
      end
    end
end
