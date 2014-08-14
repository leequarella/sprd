class AddStatusToSkaters < ActiveRecord::Migration
  def change
    add_column :skaters, :status, :string, default: "active"
  end
end
