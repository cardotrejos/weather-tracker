defmodule WeatherTrackerWeb.WeatherConditionsController do
  use WeatherTrackerWeb, :controller

  alias WeatherTracker.WeatherConditions

  def create(conn, params) do
    case WeatherConditions.create_entry(params) do
      {:ok, weather_condition} ->
        conn
        |> put_status(:created)
        |> json(weather_condition)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: format_errors(changeset)})
    end
  end

  defp format_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
