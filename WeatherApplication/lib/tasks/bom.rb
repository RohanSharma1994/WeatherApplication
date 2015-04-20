# This script scrapes data from bom.gov.au
require 'nokogiri'
require 'open-uri'

# Constants
URL = 'http://www.bom.gov.au/vic/observations/melbourne.shtml'

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
	puts "Name:#{row.css('th').text}|Temp:#{[headers~='obs-temp'].text}|Dew_Point:#{[headers~='obs-dewpoint'].text}|Wind_Speed:#{[headers~='obs-wind-spd-kph'].text}|Wind_Direction:#{[headers~='obs-wind-dir'].text}|Rainfall_amount:#{[headers~='obs-rainsince9am'].text}"
end