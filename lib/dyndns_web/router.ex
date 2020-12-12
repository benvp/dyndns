defmodule DyndnsWeb.Router do
  use DyndnsWeb, :router

  import Plug.BasicAuth

  @config Application.get_env(:dyndns, DyndnsWeb.Router)

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DyndnsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :basic_auth, username: @config[:username], password: @config[:password]
  end

  # Currently we only support api routes
  # scope "/", DyndnsWeb do
  #   pipe_through :browser

  #   live "/", PageLive, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api", DyndnsWeb do
    pipe_through :api

    get "/update", DnsController, :update
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: DyndnsWeb.Telemetry
    end
  end
end
