class CreateWindObservations < ActiveRecord::Migration
  def change
    create_table :wind_observations do |t|
      t.float :wind_speed
      t.string :wind_direction
      t.datetime :time

      t.timestamps null: false
    end
  end
end
