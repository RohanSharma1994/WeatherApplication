class RemoveTimeFromWindObservation < ActiveRecord::Migration
  def change
    remove_column :wind_observations, :time, :datetime
  end
end
