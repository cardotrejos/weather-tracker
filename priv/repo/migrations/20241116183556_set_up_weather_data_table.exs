defmodule WeatherTracker.Repo.Migrations.SetUpWeatherDataTable do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE")

    create table(:weather_conditions, primary_key: false) do
      add :timestamp, :naive_datetime, null: false
      add :altitude_m, :decimal, null: false
      add :pressure_pa, :decimal, null: false
      add :temperature_c, :decimal, null: false
      add :co2_eq_ppm, :decimal, null: false
      add :tvoc_ppb, :decimal, null: false
      add :light_lumens, :decimal, null: false
      add :humidity, :decimal, null: false
    end

    execute("SELECT create_hypertable('weather_conditions', 'timestamp')")
  end

  def down do
    execute("DROP EXTENSION IF EXISTS timescaledb")
    drop table(:weather_conditions)
  end
end
