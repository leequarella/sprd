class AttendencePercentageReport
  attr_accessor :practices, :skaters
  def initialize(data)
    @skaters = Skater.all
    @practices = Practice.where("date > ? and date < ?", data[:start_date], data[:end_date])
    calc
  end

  private
    def calc
      @skaters.each do |skater|
        credit    = 0
        @practices.each do |practice|
          credit += 1 if skater.attended?(practice)
        end
        skater.attendence_percentage = (credit.to_f/@practices.length.to_f) * 100
      end
    end
end
