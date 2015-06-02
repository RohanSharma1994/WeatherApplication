RECORDINGS_PER_HOUR = 6
class DailyObservation < ActiveRecord::Base
	belongs_to :weather_station
	has_many :temperature_observations
	has_many :wind_observations
	has_many :rain_observations

	# A function which returns "-" if the item is null
	def validate item
		if(not item)
			return "-"
		else
			return item.to_s
		end
	end

	# A function which returns the latest recorded temperature for this observation
	def latest_temperature
		validate self.temperature_observations.order("created_at").last.current_temperature
	end

	# A function which returns the latest recorded dew-point for this observation
	def latest_dew_point
		validate self.temperature_observations.order("created_at").last.dew_point
	end

	# A function which returns the latest recorded wind speed for this observation
	def latest_wind_speed
		validate self.wind_observations.order("created_at").last.wind_speed
	end

	# A function which returns the latest recorded wind direction for this observation
	def latest_wind_direction
		validate self.wind_observations.order("created_at").last.wind_direction
	end

	# A function which returns the latest recorded rainfall for this observation
	def latest_rainfall_amount
		validate self.rain_observations.order("created_at").last.rainfall_amount
	end

	# A function which returns the total amount of rainfall for this observation
	def total_rainfall
		sum = 0
		count = 0
		for rain_observation in self.rain_observations.order("created_at ASC")
			if(count == 0)
				sum+=rain_observation.rainfall_amount
			else
				sum+=rain_observation.rainfall_amount.to_f/RECORDINGS_PER_HOUR
			end
			count = count + 1
		end
		return sum
	end
end
