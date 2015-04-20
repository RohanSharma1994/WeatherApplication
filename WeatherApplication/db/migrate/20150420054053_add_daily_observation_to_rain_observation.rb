class AddDailyObservationToRainObservation < ActiveRecord::Migration
  def change
    add_reference :rain_observations, :daily_observation, index: true, foreign_key: true
  end
end
