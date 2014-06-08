class Practice < ActiveRecord::Base
  has_many :skater_practices, dependent: :destroy
  has_many :skaters, through: :skater_practices
end
