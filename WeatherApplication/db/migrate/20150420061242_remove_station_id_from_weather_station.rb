class RemoveStationIdFromWeatherStation < ActiveRecord::Migration
  def change
    remove_column :weather_stations, :station_id, :string
  end
end
