class SkaterPractice < ActiveRecord::Base
  belongs_to :practice
  belongs_to :skater
end
