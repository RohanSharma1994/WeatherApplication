class CreateTemperatureObservations < ActiveRecord::Migration
  def change
    create_table :temperature_observations do |t|
      t.float :current_temperature
      t.float :dew_point
      t.datetime :time

      t.timestamps null: false
    end
  end
end
