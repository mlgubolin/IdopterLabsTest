# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :forum,
  ecto_repos: [Forum.Repo]

# Configures the endpoint
config :forum, ForumWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4WT7MoUxpSXoIxE7ygoro4/5XFsgAhMl/+gGEO0+2VKaEpvv2Qq/TFoXVa55yd7A",
  render_errors: [view: ForumWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Forum.PubSub,
  live_view: [signing_salt: "hrP2oPn2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
