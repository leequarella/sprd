class Skater < ActiveRecord::Base
  has_many :skater_practices
  has_many :practices, through: :skater_practices
end
