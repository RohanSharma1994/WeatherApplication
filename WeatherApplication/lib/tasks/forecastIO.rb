# This script scrapes data from Forecast.io
require 'json'
require 'nokogiri'
require 'open-uri'

# Constants
BASE_URL = 'https://api.forecast.io/forecast'
API_KEY = '8853c97154dd2a79c781123b4f3b39c5'
UNITS = '?units=ca'

# Get all the weather stations from the database
weather_stations = WeatherStation.all

# For each of the weather stations in the database
# get the current prediction from forecast.io
for weather_station in weather_stations
	# Get the lat,lon location 
	lat_lon= "#{weather_station.lat},#{weather_station.lon}"
	link = "#{BASE_URL}/#{API_KEY}/#{lat_lon}#{UNITS}"
	# Get the forecast
	forecast = JSON.parse(open(link).read)
	time = Time.new
	if(time.hour > 9) 
		time_since_9am = time.hour - 9 + time.min.to_f/60 + time.sec.to_f/3600
	elsif(time.hour == 9) 
		time_since_9am = time.min.to_f/60+time.sec.to_f/3600
	else
		time_since_9am = (24-9)+time.hour+time.min.to_f/60+time.sec.to_f/3600
	end
	# Print the weather
	puts "Name:#{weather_station.name}|Temp:#{forecast['currently']['temperature']}|Dew_Point:#{forecast['currently']['dewPoint']}|Wind_Speed:#{forecast['currently']['windSpeed']}|Wind_Direction:#{forecast['currently']['windBearing']}|Rainfall_amount:#{forecast['currently']['precipIntensity']*time_since_9am}"
end