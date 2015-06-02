class RemoveTimeFromRainObservation < ActiveRecord::Migration
  def change
    remove_column :rain_observations, :time, :datetime
  end
end
