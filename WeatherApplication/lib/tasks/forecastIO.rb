# This script scrapes data from Forecast.io
require 'json'
require 'nokogiri'
require 'open-uri'

# Constants
BASE_URL = 'https://api.forecast.io/forecast'
API_KEY = '8853c97154dd2a79c781123b4f3b39c5'
UNITS = '?units=ca'
SOURCE = 'Forecast IO'

# A function which gets the time
# since 9am.
def get_time_since_9am()
	time = Time.new
	if(time.hour > 9) 
		time_since_9am = time.hour - 9 + time.min.to_f/60 + time.sec.to_f/3600
	elsif(time.hour == 9) 
		time_since_9am = time.min.to_f/60+time.sec.to_f/3600
	else
		time_since_9am = (24-9)+time.hour+time.min.to_f/60+time.sec.to_f/3600
	end
	return time_since_9am
end

# Get all the weather stations from the database
weather_stations = WeatherStation.all

# For each of the weather stations in the database
# get the current prediction from forecast.io
for weather_station in weather_stations
	# Create a daily observation for this weather station
	daily_observation = weather_station.daily_observations.create(source:SOURCE, date_time:Time.now)
	# Get the lat,lon location 
	lat_lon= "#{weather_station.lat},#{weather_station.lon}"
	link = "#{BASE_URL}/#{API_KEY}/#{lat_lon}#{UNITS}"
	# Get the forecast
	forecast = JSON.parse(open(link).read)
	# Calculate the time since 9am
	time_since_9am = get_time_since_9am
	# Parse the data
	temp = forecast['currently']['temperature']
	dew_point = forecast['currently']['dewPoint']
	wind_spd = forecast['currently']['windSpeed']
	wind_dir = forecast['currently']['windBearing']
	rainfall_amount = forecast['currently']['precipIntensity']*time_since_9am
	# Store the data for this daily observation in the database
	daily_observation.temperature_observation.create(current_temperature:temp, dew_point:dew_point)
	daily_observation.wind_observation.create(wind_speed:wind_spd, wind_direction:wind_dir)
	daily_observation.rain_observation.create(rainfall_amount:rainfall_amount)	
end