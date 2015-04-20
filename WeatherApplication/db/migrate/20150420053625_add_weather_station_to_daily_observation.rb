class AddWeatherStationToDailyObservation < ActiveRecord::Migration
  def change
    add_reference :daily_observations, :weather_station, index: true, foreign_key: true
  end
end
