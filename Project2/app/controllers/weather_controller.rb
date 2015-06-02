class WeatherController < ApplicationController
  def data
  	@weather_stations = WeatherStation.all
  end
end
