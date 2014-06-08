class Skater < ActiveRecord::Base
  attr_accessor :attendence_percentage
  has_many :skater_practices
  has_many :practices, through: :skater_practices

  def attended?(practice)
    skater_practice = SkaterPractice.where(skater: self, practice: practice).first
    if !skater_practice || skater_practice.status == 'absent'
      false
    else
      true
    end
  end

  def status_for(practice)
    skater_practice = SkaterPractice.where(skater: self, practice: practice).first
    if !skater_practice
      'absent'
    else
      skater_practice.status
    end
  end

  def attendence_percentage_for practices
    credit = 0
    practices.each do |practice|
      credit += 1 if self.attended?(practice)
    end
    self.attendence_percentage = (credit.to_f/practices.length.to_f) * 100
  end

  def roster_eligible? date_range
    if attendence_percentage_for_day_of_week('Wed', date_range) == 100 &&
       attendence_percentage_for_day_of_week('Sun', date_range) > 50
      true
    else
      false
    end
  end

  private
  def attendence_percentage_for_day_of_week(day_of_week, date_range)
    practices = Practice.where("date > ? and date < ?", date_range[:from], date_range[:to])
    practices_count = 0
    attended_count = 0
    practices.each do |practice|
      if practice.date.strftime('%a') == day_of_week
        practices_count += 1
        attended_count  += 1 if self.attended?(practice)
      end
    end
    return 100 if practices_count == 0
    (attended_count/practices_count)*100
  end
end
