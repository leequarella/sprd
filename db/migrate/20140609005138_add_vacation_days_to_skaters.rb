class AddVacationDaysToSkaters < ActiveRecord::Migration
  def change
    add_column :skaters, :vacation_days, :integer, default: 5
  end
end
