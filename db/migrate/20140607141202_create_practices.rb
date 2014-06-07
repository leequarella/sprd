class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
