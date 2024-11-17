defmodule WeatherTracker.Repo.Migrations.MakeTvocNullable do
  use Ecto.Migration

  def change do
    alter table(:weather_conditions) do
      modify :tvoc_ppb, :float, null: true
    end
  end
end
