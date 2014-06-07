class CreateSkaterPractices < ActiveRecord::Migration
  def change
    create_table :skater_practices do |t|
      t.integer :skater_id
      t.integer :practice_id
      t.string :status

      t.timestamps
    end
  end
end
