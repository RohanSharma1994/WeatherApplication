# This file provides useful functions which can 
# be used by all the different scrapers
require 'date'

# Checks if string is a number.
# If it is returns the float value of it
# Otherwise returns nil
def numeric string
    Float(string) rescue nil
end

# A function which persists the data in the database
# station_name: Name of the station you want to save the data for
# source: The name of the source which the data is scraped from
# temperature; The current temperature in celcius
# dew_point: The current dew point in celcius
# wind_spd: The current wind speed in km/h
# wind_dir: The current wind direction
# The rain amount: Precipitation intensity in mm/h
def persist_data station_name, source, temperature, dew_point, wind_spd, wind_dir, rain_amount
	# Convert all the input to float
	temperature = numeric temperature
	dew_point = numeric dew_point
	wind_spd = numeric wind_spd
	rain_amount = numeric rain_amount
	# Find the weather station in the database
	weather_station = WeatherStation.find_by(name:station_name)
	# Only persist the data if this weather station exists
	if(weather_station)
		# Check if there is a daily observation today for this source
		daily_observation = weather_station.daily_observations.where(date:Date.today).where(source:source).first
		# If there isn't one create the daily observation
		if(not daily_observation) 
			daily_observation = weather_station.daily_observations.create(date:Date.today, source:source)
		end
		# Persist the data for this daily observation
		daily_observation.temperature_observations.create(current_temperature:temperature, dew_point:dew_point)
		daily_observation.wind_observations.create(wind_speed:wind_spd, wind_direction:wind_dir)
		daily_observation.rain_observations.create(rainfall_amount:rain_amount)
	end
end