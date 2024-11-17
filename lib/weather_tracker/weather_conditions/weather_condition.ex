defmodule WeatherTracker.WeatherConditions.WeatherCondition do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed_fields [
    :timestamp,
    :altitude_m,
    :temperature_c,
    :humidity,
    :pressure_pa,
    :gas_resistance_ohms,
    :dew_point_c,
    :voc_index,
    :light_lumens,
    :tvoc_ppb
  ]

  @derive {Jason.Encoder, only: @allowed_fields}
  @primary_key false
  schema "weather_conditions" do
    field :timestamp, :utc_datetime
    field :altitude_m, :decimal
    field :temperature_c, :decimal
    field :humidity, :decimal
    field :pressure_pa, :decimal
    field :gas_resistance_ohms, :decimal
    field :dew_point_c, :decimal
    field :voc_index, :integer
    field :light_lumens, :decimal
    field :tvoc_ppb, :decimal
  end

  def create_changeset(weather_condition = %__MODULE__{}, attrs) do
    timestamp = DateTime.utc_now() |> DateTime.truncate(:second)

    weather_condition
    |> cast(attrs, @allowed_fields)
    |> put_change(:timestamp, timestamp)
    |> validate_required(@allowed_fields -- [:timestamp])
  end
end
