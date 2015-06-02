class CreateDailyObservations < ActiveRecord::Migration
  def change
    create_table :daily_observations do |t|
      t.date :date
      t.string :source

      t.timestamps null: false
    end
  end
end
