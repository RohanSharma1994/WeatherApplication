# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150420061242) do

  create_table "daily_observations", force: :cascade do |t|
    t.datetime "date_time"
    t.string   "source"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "weather_station_id"
  end

  add_index "daily_observations", ["weather_station_id"], name: "index_daily_observations_on_weather_station_id"

  create_table "rain_observations", force: :cascade do |t|
    t.float    "rainfall_amount"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "daily_observation_id"
  end

  add_index "rain_observations", ["daily_observation_id"], name: "index_rain_observations_on_daily_observation_id"

  create_table "temperature_observations", force: :cascade do |t|
    t.float    "current_temperature"
    t.float    "dew_point"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "daily_observation_id"
  end

  add_index "temperature_observations", ["daily_observation_id"], name: "index_temperature_observations_on_daily_observation_id"

  create_table "weather_stations", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wind_observations", force: :cascade do |t|
    t.float    "wind_speed"
    t.string   "wind_direction"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "daily_observation_id"
  end

  add_index "wind_observations", ["daily_observation_id"], name: "index_wind_observations_on_daily_observation_id"

end
