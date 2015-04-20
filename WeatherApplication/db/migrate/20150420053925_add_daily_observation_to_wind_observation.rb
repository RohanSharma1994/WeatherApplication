class AddDailyObservationToWindObservation < ActiveRecord::Migration
  def change
    add_reference :wind_observations, :daily_observation, index: true, foreign_key: true
  end
end
