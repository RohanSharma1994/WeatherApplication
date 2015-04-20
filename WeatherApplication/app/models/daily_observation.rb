class DailyObservation < ActiveRecord::Base
	belongs_to :weather_station
	has_many :temperature_observations
	has_many :wind_observations
	has_many :rain_observations
end
