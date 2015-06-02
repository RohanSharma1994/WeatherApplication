# This script scrapes data from forecast.IO
require 'json'
require 'open-uri'
require_relative 'persist_functions'

# Constants
SOURCEFIO = 'FIO'
API_KEY = '8853c97154dd2a79c781123b4f3b39c5'
BASE_URL = 'https://api.forecast.io/forecast'
UNITS = '?units=ca'

# A function which scrapes the data from forecast.IO
def scrape_fio_data
	# Get all the weather stations
	weather_stations = WeatherStation.all
	# For each of these weather stations get the forecast
	for weather_station in weather_stations
		lat_lon = "#{weather_station.lat},#{weather_station.lon}"
		forecast = JSON.parse(open("#{BASE_URL}/#{API_KEY}/#{lat_lon}#{UNITS}").read)
		# Parse the data which is required
		temperature = forecast['currently']['temperature']
		dew_point = forecast['currently']['dewPoint']
		wind_spd = forecast['currently']['windSpeed']
		wind_dir = forecast['currently']['windBearing']
		rain = forecast['currently']['precipIntensity']
		persist_data weather_station.name, SOURCEFIO, temperature, dew_point, wind_spd, wind_dir, rain
	end
end