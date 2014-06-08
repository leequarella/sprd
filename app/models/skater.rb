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
end
