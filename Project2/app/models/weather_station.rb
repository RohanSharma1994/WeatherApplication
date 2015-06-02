class WeatherStation < ActiveRecord::Base
	has_many :daily_observations

	# A function which returns the latest observation for this
	# weather station for a given source. Returns nil if it doesn't have an observation
	# for the given source
	def latest_observation source
		self.daily_observations.where(source:source).order("date").last
	end
end
