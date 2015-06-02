class RemoveTimeFromTemperatureObservation < ActiveRecord::Migration
  def change
    remove_column :temperature_observations, :time, :datetime
  end
end
