class WeatherStation < ActiveRecord::Base
	has_many :daily_observations
end
