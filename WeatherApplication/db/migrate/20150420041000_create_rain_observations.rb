class CreateRainObservations < ActiveRecord::Migration
  def change
    create_table :rain_observations do |t|
      t.float :rainfall_amount

      t.timestamps null: false
    end
  end
end
