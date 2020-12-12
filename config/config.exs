# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dyndns,
  ecto_repos: [Dyndns.Repo]

# Configures the endpoint
config :dyndns, DyndnsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BMgb8d5DJjBor2piArHwIreICC87D5S7DAuItTnvCGOCOObwUvIWLIBPP5pbgyO1",
  render_errors: [view: DyndnsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Dyndns.PubSub,
  live_view: [signing_salt: "ehVRUGa8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
