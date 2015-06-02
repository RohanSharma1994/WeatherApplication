class TemperatureObservation < ActiveRecord::Base
	belongs_to :daily_observation
end
