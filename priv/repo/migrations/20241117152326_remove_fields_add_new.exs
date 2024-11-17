defmodule WeatherTracker.Repo.Migrations.RemoveFieldsAddNew do
  use Ecto.Migration

  def change do
    alter table(:weather_conditions) do
      add :gas_resistance_ohms, :decimal
      add :dew_point_c, :decimal
      add :voc_index, :integer
      remove :co2_eq_ppm
    end
  end
end
