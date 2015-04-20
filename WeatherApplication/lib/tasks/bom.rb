# This script scrapes data from bom.gov.au
require 'nokogiri'
require 'open-uri'

# Check if string is a number


# Constants
URL = 'http://www.bom.gov.au/vic/observations/melbourne.shtml'
SOURCE = "Bureau Of Meteorology"

# Open the HTML link with Nokogiri
doc = Nokogiri::HTML(open(URL))

# Get the table which contains Melbourne's data
table = doc.css('#tMELBOURNE')
# Get the body of the table
body = table.css('tbody')
# Get all the rows from the table body
rows = body.css('tr')

# Get the data from each row
for row in rows
	# Find the weather station record
	weather_station = WeatherStation.find_by(name:"#{row.css('th').text}")
	# Ensure this weather station is stored as a location
	if(not weather_station.empty?)
		# Create a daily observation for this weather station
		daily_observation = weather_station.daily_observations.create(source:SOURCE, date_time:Time.now)
		# Parse all the data that needs to be stored
		temp = row.css('[headers~=obs-temp]').text
		dew_point = row.css('[headers~=obs-dewpoint]').text
		wind_spd = row.css('[headers~=obs-wind-spd-kph]').text}
	    wind_dir = row.css('[headers~=obs-wind-dir]').text}
	    rainfall_amount = row.css('[headers~=obs-rainsince9am]').text
		# Store the data for this daily observation in the database
		daily_observation.temperature_observation.create(current_temperature:temp, dew_point:dew_point)
		daily_observation.wind_observation.create(wind_speed:wind_spd, wind_dir:wind_dir)
		daily_observation.rain_observation.create(rainfall_amount:rainfall_amount)
	end
end 