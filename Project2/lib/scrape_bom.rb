# This script scrapes data from Bureau of Meteorology 
require 'open-uri'
require 'nokogiri'
require_relative 'persist_functions'

# Constants
URL = 'http://www.bom.gov.au/vic/observations/melbourne.shtml'
SOURCEBOM = 'BOM'
RECORDINGS_PER_HOUR = 6

# Converts rain since 9am to precipIntensity in mm/hr
# Each 10 minute interval will tell the precipitaion
# intensity in mm/10 min so to convert this to mm/hr
# just needs to times by 6.
def convert_to_intensity station_name, rain
	# Get the numeric value
	rain = numeric rain
	if(rain)
		# Get how much rain has occured from previous data point on same day to this data point
		weather_station = WeatherStation.find_by(name:station_name)
		if(weather_station)
			daily_observation = weather_station.daily_observations.where(date:Date.today).where(source:SOURCEBOM).first
			if(not daily_observation)
				# This is the first observation for the day
				return rain.to_f
			else
				# Get the total rain that has fallen today
				total_rain = daily_observation.total_rainfall
				# Work out how much rain fell in this increment
				# This will give precipitation intensity as mm/10min
				# It can be converted to mm/hr it can be multiplied by 6
				return (rain - total_rain)*RECORDINGS_PER_HOUR
			end
		end
	else
		return 0
	end
end

# A function which scrapes the data for the BOM website
def scrape_bom_data
	# Open the HTML link with Nokogiri
	doc = Nokogiri::HTML(open(URL)) 
	# Get the table for Melbourune
	table = doc.css('#tMELBOURNE')
	# Get the table body
	body = table.css('tbody')
	# Get each of the rows in the table body
	rows = body.css('tr')
	# Traverse through each table row and scrape the data
	for row in rows
		station_name = row.css('th').text
		# Use attribute selectors to scrape the data from each row
		temperature = row.css('[headers~=obs-temp]').text
		dew_point = row.css('[headers~=obs-dewpoint]').text
		wind_speed = row.css('[headers~=obs-wind-spd-kph]').text
		wind_dir = row.css('[headers~=obs-wind-dir]').text
		rain = convert_to_intensity station_name, row.css('[headers~=obs-rainsince9am]').text
		# Persist this data
		persist_data station_name, SOURCEBOM, temperature, dew_point, wind_speed, wind_dir, rain
	end
end