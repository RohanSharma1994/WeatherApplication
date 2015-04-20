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
	print "Name:#{row.css('th').text}|"
	print "Temp:#{row.css('[headers~=obs-temp]').text}|"
	print "Dew_Point:#{row.css('[headers~=obs-dewpoint]').text}|"
	print "Wind_Speed:#{row.css('[headers~=obs-wind-spd-kph]').text}|"
	print "Wind_Direction:#{row.css('[headers~=obs-wind-dir]').text}|"
	puts "Rainfaull_Amount:#{row.css('[headers~=obs-rainsince9am]').text}"
end