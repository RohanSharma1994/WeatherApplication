class CreateWeatherStations < ActiveRecord::Migration
  def change
    create_table :weather_stations do |t|
      t.string :name
      t.string :station_id
      t.float :lat
      t.float :lon

      t.timestamps null: false
    end
  end
end