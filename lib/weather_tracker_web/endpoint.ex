defmodule WeatherTrackerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :weather_tracker
  import Phoenix.Controller, only: [put_secure_browser_headers: 2]

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_weather_tracker_key",
    signing_salt: "C/pbzZ43",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :weather_tracker,
    gzip: false,
    only: WeatherTrackerWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :weather_tracker
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug :put_secure_browser_headers, %{
    "content-security-policy" => "default-src 'self'; frame-src 'self' https://monitoreo.cardotrejos.com; script-src 'self' 'unsafe-inline' 'unsafe-eval' https://monitoreo.cardotrejos.com; style-src 'self' 'unsafe-inline' https://monitoreo.cardotrejos.com; img-src 'self' data: https://monitoreo.cardotrejos.com"
  }
  plug WeatherTrackerWeb.Router
end
