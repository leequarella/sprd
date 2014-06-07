class Practice < ActiveRecord::Base
  has_many :skater_practices
  has_many :skaters, through: :skater_practices
end
