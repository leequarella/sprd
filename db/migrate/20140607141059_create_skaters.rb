class CreateSkaters < ActiveRecord::Migration
  def change
    create_table :skaters do |t|
      t.string :first_name
      t.string :last_name
      t.string :derby_name
      t.string :email

      t.timestamps
    end
  end
end
