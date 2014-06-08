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
end
