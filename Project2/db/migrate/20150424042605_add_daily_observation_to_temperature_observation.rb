class AddDailyObservationToTemperatureObservation < ActiveRecord::Migration
  def change
    add_reference :temperature_observations, :daily_observation, index: true, foreign_key: true
  end
end
