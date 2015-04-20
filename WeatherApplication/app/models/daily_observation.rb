class DailyObservation < ActiveRecord::Base
	belongs_to :weather_station
	has_one :temperature_observation
	has_one :wind_observation
	has_one :rain_observation
end
